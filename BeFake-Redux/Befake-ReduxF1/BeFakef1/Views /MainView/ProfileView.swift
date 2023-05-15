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
                    ProgressView()
                }
            }
           
            .navigationTitle("MyProfile.")
            Divider()
                
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("LogOut.", action: logOutUser)
                        Button("DeleteAccount.",role:.destructive, action: deletAccount)
                    } label: {
                        Image(systemName: "ellipsis")
                            .tint(.white)
                            .scaleEffect(1)
                    }
                }
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
    }
    
    func fetchUserData()async{
        guard let userUID = Auth.auth().currentUser?.uid else{return}
        guard let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self)
        else{return}
        await MainActor.run(body: {
            myProfile = user
        })
    }
    
    func logOutUser(){
        try? Auth.auth().signOut()
        logStatus = false
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
                logStatus = false
            }catch{
                await setError(error)
            }
            
        }
    }
    
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
