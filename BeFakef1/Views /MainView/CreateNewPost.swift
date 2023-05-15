//
//  CreateNewPost.swift
//  BeFakef1
//
//  Created by Elijah Senior on 4/29/23.
//

import SwiftUI
import  PhotosUI
import Firebase
import FirebaseStorage


struct CreateNewPost: View {
    
    var onPost: (Post)->()
    
    @State var postText: String = ""
    @State var postImageData: Data?
    
    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userNameStored: String = ""
    @AppStorage("user_UID") private var userUID: String = ""
    
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @FocusState private var showKeyboard: Bool
    var body: some View {
        VStack{
            HStack{
                Menu{
                    Button("Cancel", role: .destructive){
                        dismiss()
                    }
                } label: {
                    Text("Cancel ")
                        .font(.callout)
                        .foregroundColor(.white)
                }
                .hAlign(.leading)
                
                Button(action: createPost){
                    Text("Post")
                        .font(.callout)
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                        .background(.white, in: Capsule())
                    
                }
                .disablewithOpacity(postText == "")
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                Rectangle()
                    .fill(.gray.opacity(0.05))
                    .ignoresSafeArea()
            }
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 15){
                    TextField("What's Happening?", text: $postText, axis: .vertical)
                        .focused($showKeyboard)
                    
                    if let postImageData, let image = UIImage(data: postImageData){
                        GeometryReader{
                            let size = $0.size
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            
                            //Delete Button
                                .overlay(alignment: .topTrailing){
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.25)){
                                            self.postImageData = nil
                                        }
                                    } label: {
                                        Image(systemName: "trash.square")
                                            .tint(.red)
                                            .fontWeight(.bold)
                                    }
                                    .padding(10)
                                }
                                
                        }
                        .clipped()
                        .frame(height: 220)
                    }
                }
                .padding(15)
            }
            
            Divider()
            
            HStack{
                Button {
                    showImagePicker.toggle()
                } label: {
                    Image(systemName: "plus.square.dashed")
                        .font(.title)
                        .foregroundColor(.white)
                
                }
                .hAlign(.leading)
                
                Button("Done"){
                    showKeyboard = false
//                    NavigationStack {
<<<<<<< HEAD
//                        PostsView()
//                    }
                    
=======
//                      PostsView()
//                    }
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
                }
                .font(.title3)
                .foregroundColor(.white)
//                .disablewithOpacity( postImageData == "")
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 5)
            
        }
        .vAlign(.top)
        .photosPicker(isPresented: $showImagePicker , selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            if let newValue{
                Task{
                    if let rawImageData = try? await newValue.loadTransferable(type: Data.self), let image = UIImage(data: rawImageData), let compressedImageData = image.jpegData(compressionQuality: 0.5){
                        
                        await MainActor.run(body: {
                            postImageData = compressedImageData
                            photoItem = nil
                        })
                    }
                }
            }
            
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
        
        .overlay {
            LoadingView(show: $isLoading)
        }
    }
    
    func createPost(){
        isLoading = true
        showKeyboard = false
        Task{
            do{
                guard let profileURL = profileURL else {return}
                
                let imageReferenceID = "\(userUID)\(Data())"
                let storageRef = Storage.storage().reference().child("Post_Images").child(imageReferenceID)
                if let postImageData{
                    let _ = try await storageRef.putDataAsync(postImageData)
                    let downloadURL = try await storageRef.downloadURL()
                    
                    let post = Post(text: postText, imageURL: downloadURL, imageReferenceID: imageReferenceID, userName: userNameStored, userUID: userUID, userProfileURL: profileURL)
<<<<<<< HEAD
                    
=======
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
                    try await createDocumentAtFirebase(post)
                }else{
                  
                    let post = Post(text: postText, imageReferenceID: imageReferenceID, userName: userNameStored, userUID: userUID, userProfileURL: profileURL)
                    try await createDocumentAtFirebase(post)
                }
            }catch{
                await setError(error)
            }
        }
    }
    
    func createDocumentAtFirebase(_ post: Post)async throws{
        let _ = try Firestore.firestore().collection("Posts").addDocument(from: post, completion: { error in
            if error == nil {
                isLoading = false
                onPost(post)
                dismiss()
            }
        })
    }
    
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

struct CreateNewPost_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPost{_ in
            
        }
    }
}
