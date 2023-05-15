//
//  RegisterView.swift
//  BeFakef1
//
//  Created by Elijah Senior on 4/17/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import PhotosUI
struct RegisterView: View{
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var userBio: String = ""
    @State var userBioLink: String = ""
    @State var errorMessage: String = ""
    @State var userProfilePicData: Data?
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var showError: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var isLoading: Bool = false
    @State var signUpIsShown: Bool = false
    
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    var body: some View{
        
        Button {
            signUpIsShown.toggle()
            
        } label: {
            Text("SignUp")
                .font(Font.system(size: 40, design: .monospaced))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .hAlign(.center)
                .fillView(.black)
                .padding(.top, 100)
                .padding(.horizontal, 15)
                .offset(y: -70)
            
            
            
        }
        .fullScreenCover(isPresented: $signUpIsShown) {
            RegisterView()
        }
        ViewThatFits{
            ScrollView(.vertical, showsIndicators: false) {
                HelperView()
            }
            HelperView()
        }
        
        HStack {
            Text("Already have an account?")
                .fontWeight(.thin)
                .font(.callout)
                .vAlign(.bottom)
            
            
            Button("Login Now"){
                dismiss()
                
            }
            .font(.callout)
            .vAlign(.bottom)
            .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
            .onChange(of: photoItem) { newValue in
                
                if let newValue{
                    Task{
                        do{
                            guard let imageData = try await newValue.loadTransferable(type: Data.self)
                            else{return}
                            await MainActor.run(body: {
                                userProfilePicData = imageData
                            })
                        }catch{}
                    }
                }
            }
        }
        
        
        .alert(errorMessage, isPresented: $showError, actions:{})
        
    }
    
    
    
    @ViewBuilder
    func HelperView()-> some View{
        
        VStack(spacing: 1){
            
            
            
            ZStack{
                if let userProfilePicData, let image = UIImage(data: userProfilePicData){
                    Image(uiImage: image)
                        .resizable()
                        .offset(x: 0, y: 0)
                        .aspectRatio(contentMode: .fill)
                    
                    
                }else{
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    
                    
                }
            }
            .frame(width: 110, height: 110)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture{
                showImagePicker.toggle()
            }
            .offset(y: 30)
            
            
            
            VStack(spacing: 1){
                HStack(spacing: 1) {
                    Image(systemName: "person.circle.fill")
                        .padding(.top, 20)
                        .offset(x:18, y:98)
                    Text("Click on Profile Icon").bold()
                        .textContentType(.emailAddress)
                    
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.top, -40)
                        .padding(.horizontal, 35)
                        .offset(y: -10)
                    
                    TextField("Username", text: $userName)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.2))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.top, 20)
                        .padding(.horizontal, -135)
                        .offset(y: 95)
                    
                }
                
                HStack {
                    Image(systemName: "person.text.rectangle.fill")
                        .padding(.top, 55)
                        .offset(x:15, y:62)
                    TextField("Email", text: $emailID)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.2))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.top, 55)
                        .padding(.horizontal, 20)
                        .offset(x:-5, y: 60)
                    
                }
                
                HStack {
                    Image(systemName: "door.left.hand.closed")
                        .padding(.top, 60)
                        .offset(x: 21, y: 22)
                    SecureField("Password", text: $password)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.2))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.top, 60)
                        .padding(.horizontal, 23)
                        .offset(y: 20)
                    
                    
                }
                HStack {
                    Image(systemName: "pencil.circle.fill")
                        .offset(x:20 ,y:10)
                    TextField("Bio", text: $userBio, axis: .vertical)
                        .frame(minHeight: 25, alignment: .top)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.2))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(.top, 60)
                        .padding(.horizontal, 28)
                        .offset(x:-7 ,y: -19)
                }
                
                TextField("Link for bio (Optional)", text: $userBioLink)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.2))
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.top, 60)
                    .padding(.horizontal, 41)
                    .offset(x:7 ,y: -73)
                
                
                Button(action: registerUser){
                    Text("Ready to SignUp")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .hAlign(.center)
                        .fillView(.white)
                        .padding(.top, 50)
                        .padding(.horizontal, 25)
                        .offset(y: -90)
                    
                }
                
                Text("BeFake")
                    .multilineTextAlignment(.center)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding(.top, -60)
                
                
                
                
                
            }
            
        }
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
    }
    
    func registerUser(){
       // isLoading = true
        // closeKeyboard()
        Task{
            do{
                
                try await Auth.auth().createUser(withEmail: emailID, password: password)
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                guard let imageData = userProfilePicData else{return}
                let storageRef =  Storage.storage().reference().child("Profile_Images").child(userUID)
                let _ = try await storageRef.putDataAsync(imageData)
                let downloadURL = try await storageRef.downloadURL()
                let user = User(username: userName, userBio: userBio, userBioLink: userBioLink, userUID: userUID, userEmail: emailID, userProfileURL: downloadURL)
                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: {
                    error in
                    if error == nil{
                        print("Saved Successfully")
                        userNameStored = userName
                        self.userUID = userUID
                        profileURL = downloadURL
                        logStatus = true
                        isLoading = false
                        
                    }
                })
            }catch{
                await setError(error)
            }
        }
        
    }

    func setError(_ error: Error)async{
        await MainActor.run(body:{
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
    @MainActor
    func setError(errorstring: String ){
        errorMessage = errorstring
        showError.toggle()
        isLoading = false
    }
    
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
