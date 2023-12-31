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
    @EnvironmentObject var fbService: FireBaseService
    
    var body: some View {
        VStack(spacing: 5){
            
            Text("Login")
                .font(.largeTitle)
                .hAlign(.center)
                .fontWeight(.light)
                .padding(30)
                .background(Divider(), alignment: .bottom)
                .padding(.top, 150)
                .preferredColorScheme(.dark)
            
            VStack(spacing: 1){
                HStack {
                    Image(systemName: "person.text.rectangle.fill")
                        .padding(.top, 20)
                    TextField("Email", text: $emailID)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.2))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.top, 15)
                }
                HStack {
                    Image(systemName: "door.left.hand.closed")
                        .padding(.top, 50)
                    SecureField("Password", text: $password)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.2))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.top, 50)
                    
                }
                Button("Reset Password?", action: resetPassword )
                    .font(.callout)
                    .fontWeight(.medium)
                    .padding(.top, 5)
                    .hAlign(.trailing)
                
                Button(action: loginUser){
                    Text("Sign in")
                        .foregroundColor(.black)
                        .hAlign(.center)
                        .fillView(.white)
                        .padding(.top, 50)
                }
                
                Text("BeFake.")
                    .multilineTextAlignment(.center)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding(.top, 140)
                
                HStack {
                    Text("Don't have an account?")
                        .fontWeight(.thin)
                        .font(.callout)
                        .vAlign(.bottom)
                       
                    
                    Button("SignUp"){
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
//            do{
//                try await Auth.auth().signIn(withEmail: emailID, password: password)
//                logStatus = true
//                print("hello")
//                //Would on print "user found" and wouldn't swiitch views
//
//                logStatus = true
//                try await fetchUser()
//
//            }catch{
//               await setError(error)
//            }
            do {
                
                let (res,error) =  try await fbService.login(email: emailID, password: password)
           
                if res?.user.email?.isEmpty == false {
                   logStatus = true

                }
                await setError(error)
            }catch {
                switch error as! NetworkErrorType {
                case .firebaseError(let error):
                    await setStringError(error)
                    logStatus = false
                default:
                    await setError(error)
                    logStatus = false
                }
            }
            
        }
    }
    @MainActor
    func fetchUser()async throws{
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
            userUID = userID
            userNameStored = user.username ?? ""
            profileURL = user.userProfileURL
            logStatus = true
            // tried to set logStatus to true here and shift to main view but NOT WORKING!!! AHHHHHHHHHH
            isLoading = false
    
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
    func setStringError(_ errorString: String)async{
        await MainActor.run(body: {
            errorMessage = errorString
            showError.toggle()
            isLoading = false
        })
    }
    
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
