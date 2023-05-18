//
//  ProfileView.swift
//  BeFakef1
//
//  Created by Elijah Senior on 4/17/23.
//
//ScrollView(.vertical, showsIndicators: false){
//    if let myProfile{
//        Text(myProfile.username)
//    }
//}

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ProfileView: View {
    
    @State private var myProfile: User?
    @AppStorage("log_status") var logStatus: Bool = false
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    @State var isLoading: Bool = false
    @State var logstat: Bool = false
    @EnvironmentObject var firebaseService: FireBaseService
    @State var didLogout = false
    var body: some View {
        NavigationStack{
            VStack{
                if let myProfile{
                    ReusableProfileContent(user: myProfile)
                        .refreshable {
                            self.myProfile = nil
                            await fetchUserData()
                        }
                }else{
                    if isLoading {
                        ProgressView()
                    }
                }
            }
           
            .navigationTitle("MyProfile.")
            Divider()
                
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("LogOut.", action:{
                            Task{
                                await logOutUser()
                            }
                            
                        })
                        Button("DeleteAccount.",role:.destructive, action: deletAccount)
                    } label: {
                        Image(systemName: "ellipsis")
                            .tint(.white)
                            .scaleEffect(1)
                    }
                }
            }
            .fullScreenCover(isPresented: $didLogout) {
            
            LoginView(logStatus: $didLogout)
                
            }
        }
        .overlay {
            LoadingView(show: $isLoading)
        }
        .alert(errorMessage, isPresented: $showError){
            
        }
        .task {
            if myProfile != nil{return}
            await fetchUserData()
        }
        .refreshable {
            await fetchUserData()
        }
        
    }
    
    func fetchUserData() async{
        do {
            let user = try await firebaseService.fetchUserData()
            await MainActor.run(body: {
                myProfile = user
            })
            isLoading = false
        }catch {
           isLoading = false
            await setError(error)
        }
        
    }
    
    func logOutUser() async{
        do {
            _ = try await firebaseService.signOut()
            didLogout = true
        }catch (let error){
            switch error as! NetworkErrorType {
            case .firebaseError(let error):
                await setError(error)
                didLogout = false
            default:
                await setError(error)
                didLogout = false
            }
        }
    }
    
    func deletAccount(){
        isLoading = true
        Task{
            do{
                guard let userUID = Auth.auth().currentUser?.uid else {return}
                let reference = Storage.storage().reference().child("Profile_Images").child(userUID)
                try await reference.delete()
                    
                try await Firestore.firestore().collection("Users").document(userUID).delete()
                        
                try await Auth.auth().currentUser?.delete()
                isLoading = false
                didLogout = true
            }catch{
               // await setError(error)
                isLoading = false
                didLogout = false
            }
            
        }
    }
    
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
    func setError(_ errorString: String)async{
        await MainActor.run(body: {
            errorMessage = errorString
            showError.toggle()
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
