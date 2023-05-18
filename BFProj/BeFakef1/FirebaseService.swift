//
//  FirebaseService.swift
//  BeFakef1
//
//  Created by Clement Canel on 5/17/23.
//

import Foundation
import FirebaseAuth
import Firebase

typealias FirebaseResultClosure = (Result<AuthDataResult?, NetworkErrorType>) -> Void
protocol FirebaseAble: NetworkAble {
    func login(email: String, password: String) async throws -> FirebaseResultClosure?
    func createAccount(emai: String, password: String)  async throws -> FirebaseResultClosure?
}

class FireBaseService: ObservableObject {
    
    static let shared = FireBaseService()
    
    func loginWithCredential(credential: AuthCredential) -> Bool {
        var finalResult = false
        Auth.auth().signIn(with: credential) { result, error in
            if let error {
                print(error.localizedDescription)
              finalResult = false
            }else {
                finalResult = true
            }
        }
        return finalResult
        
    }
    
    @MainActor
    func login(email: String, password: String) async throws -> (AuthDataResult?, NetworkErrorType) {
        do {
            let res = try await Auth.auth().signIn(withEmail: email, password: password)
            return (res,.none)
            
        }catch {
            throw NetworkErrorType.firebaseError(error.localizedDescription)
        }
    
    }
    @MainActor
    func createAccount(email: String, password: String)  async throws -> (AuthDataResult?, NetworkErrorType) {
        do {
            let res = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = res.user
            print("User signed in \(user.uid)")
            return (res,.none)
            
        }catch {
            throw NetworkErrorType.firebaseError(error.localizedDescription)
        }
      
    }
    
    func signOut() async throws {
        let auth = Auth.auth()
        do {
            try auth.signOut()
        }catch {
            throw NetworkErrorType.firebaseError(error.localizedDescription)
        }
    }
    func forgotPassword(email: String) async throws {

        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            
        }catch {
            throw NetworkErrorType.firebaseError(error.localizedDescription)
        }
    }
    
    func postToFirebase(postID: String, userUID: String, data: [String: Any]) async throws {
        do {
            try await Firestore.firestore().collection("Posts").document(postID).updateData(data)
        }catch{
            throw NetworkErrorType.firebaseError(error.localizedDescription)
        }
    }
    
    func updatePost(post: Post, postID: String) throws {
        Firestore.firestore().collection("Posts").setValue(post, forKey: postID)
    }
    
    func fetchUserData()async throws -> User{
        guard let userUID = Auth.auth().currentUser?.uid else{ throw NetworkErrorType.firebaseError("User Not found")}
        do {
            let user = try await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self)
            return user
        }catch {
            throw NetworkErrorType.firebaseError(error.localizedDescription)
        }
    }
    
    func fetchPosts()async throws -> ([Post]){
        do{
            var query: Query
            query = Firestore.firestore().collection("Posts")
                .order(by: "publishedDate", descending: true)
                .limit(to: 20)
            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> Post? in
                try? doc.data(as: Post.self)
            }
            return fetchedPosts
         
        }catch{
            throw NetworkErrorType.firebaseError(error.localizedDescription)
        }
    }
    
}
