//
//  LoginView.swift
//  BeFakef1
//
//  Created by Elijah Senior on 4/16/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

// Login Returning User View
struct LoginView: View {
    @State var emailID: String = ""
    @State var password: String = ""
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    
    @Binding var logStatus: Bool
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    var body: some View {
        VStack(spacing: 5){
            
<<<<<<< HEAD
            Text("Login to Account")
=======
            Text("LogIn.")
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
                .font(.largeTitle)
                .hAlign(.center)
                .fontWeight(.light)
                .padding(30)
                .background(Divider(), alignment: .bottom)
                .padding(.top, 150)
                .preferredColorScheme(.dark)

<<<<<<< HEAD

=======
            

        
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
            
            VStack(spacing: 1){
                HStack {
                    Image(systemName: "person.text.rectangle.fill")
                        .padding(.top, 20)
<<<<<<< HEAD
                    TextField("Email", text: $emailID)
=======
                    TextField("email", text: $emailID)
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.2))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.top, 15)
                }
                HStack {
                    Image(systemName: "door.left.hand.closed")
                        .padding(.top, 50)
<<<<<<< HEAD
                    SecureField("Password", text: $password)
=======
                    SecureField("passowrd", text: $password)
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.2))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.top, 50)
                    
                }
<<<<<<< HEAD
                Button("Reset Password?", action: resetPassword )
=======
                Button("reset password?", action: resetPassword )
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
                    .font(.callout)
                    .fontWeight(.medium)
                    .padding(.top, 5)
                    .hAlign(.trailing)
                
                Button(action: loginUser){
<<<<<<< HEAD
                    Text("Signin")
=======
                    Text("SignIn.")
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
                        .foregroundColor(.black)
                        .hAlign(.center)
                        .fillView(.white)
                        .padding(.top, 50)
                }
                
<<<<<<< HEAD
                Text("BeFake")
=======
                Text("BeFake.")
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
                    .multilineTextAlignment(.center)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding(.top, 140)
                
                HStack {
<<<<<<< HEAD
                    Text("Don't have an account?")
                        .fontWeight(.thin)
                        .font(.callout)
                        .vAlign(.bottom)
                    
                    Button("SignUp"){
=======
                    Text("don't have an account?")
                        .fontWeight(.thin)
                        .font(.callout)
                        .vAlign(.bottom)
                       
                    
                    Button("SignUp."){
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
                        createAccount.toggle()
                    }
                    .font(.callout)
                    .vAlign(.bottom)
                }
                
            }
                
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        
        .fullScreenCover(isPresented: $createAccount) {
            RegisterView()

        }
        
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    func loginUser(){
        
        isLoading = true
        closeKeyboard()
        Task{
            do{
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                logStatus = true
                print("hello")
                //Would on print "user found" and wouldn't swiitch views
                
                logStatus = true
                try await fetchUser()
                
            }catch{
               await setError(error)
            }
        }
    }
    
    func fetchUser()async throws{
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
        await MainActor.run(body: {
            userUID = userID
            userNameStored = user.username
            profileURL = user.userProfileURL
            logStatus = true
            // tried to set logStatus to true here and shift to main view but NOT WORKING!!! AHHHHHHHHHH
            isLoading = false
        })
    }
    
    func resetPassword(){
        Task{
            do{
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("link sent")
            }catch{
               await setError(error)
            }
        }
        
        
    }
    
<<<<<<< HEAD
    
=======
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}


//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
////    LoginView(logSta)
//    }
//}
//
//
