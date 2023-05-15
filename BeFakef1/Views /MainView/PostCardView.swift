//
//  PostCardView.swift
//  BeFakef1
//
//  Created by Elijah Senior on 5/3/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage

struct PostCardView: View {
    var post: Post
    var onUpdate: (Post)->()
    var onDelete: ()->()
    
    @AppStorage("user_UID") private var userUID: String = ""
    
    @State private var docListener: ListenerRegistration?
    
    var body: some View {
        HStack(alignment: .top, spacing: 12){
            WebImage(url: post.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape((RoundedRectangle(cornerRadius: 25, style: .continuous)))
            
            VStack(alignment: .leading, spacing: 3){
                Text(post.userName)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                
                
                if let postImageURL = post.imageURL{
                    
                    GeometryReader{
                        let size = $0.size
                        WebImage(url: postImageURL)
                            .resizable()
                            .hAlign(.center)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    }
                    
                    
                    .frame(height: 300)
                    .hAlign(.center)
                }
                HStack{
                    Text(post.text)
                        .textSelection(.enabled)
                        .padding(.vertical, 8)
                        .font(.footnote)
                        .fontWeight(.light)
                        .padding(.horizontal)
                    PostInteraction()
                        
                }
                    Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
                        .font(.caption2)
                        .fontWeight(.light)
                        .foregroundColor(.yellow)
                    
                
            }
            
        }
        .hAlign(.leading)
      
    }
    
    @ViewBuilder
    func PostInteraction()->some View{
        HStack(spacing: 8){
            Button(action: likePost){
                Image(systemName: post.likedIDs.contains(userUID) ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.white)

            }
            Text("\(post.likedIDs.count)")
<<<<<<< HEAD
                
=======
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
                .font(.callout)
                .foregroundColor(.gray)
            
            
        }
    }
    
    func likePost(){
        Task{
<<<<<<< HEAD
            
            let postID = post.id ?? ""
            if post.likedIDs.contains(userUID)  {
        
                print("likePost")
                try await Firestore.firestore().collection("Posts").document(postID).updateData(["likedIDs": FieldValue.arrayRemove([userUID])])
            }else{
                
               try await Firestore.firestore().collection("Posts").document(postID).updateData(["likedIDs": FieldValue.arrayUnion([userUID])])
=======
            guard let postID = post.id else{return}
            if post.likedIDs.contains(userUID){
                try await Firestore.firestore().collection("Posts").document(postID).updateData(["likedIDs": FieldValue.arrayRemove([userUID])])
            }else{
                try await Firestore.firestore().collection("Posts").document(postID).updateData(["likedIDs": FieldValue.arrayUnion([userUID])])
>>>>>>> bb82a3a3c2817da05c7f70eea697f0705c5b0d8b
            }
        }
    }
    
    func dislikePost(){
        Task{
            guard let postID = post.id else{return}
            if post.dislikedIDs.contains(userUID){
                try await Firestore.firestore().collection("Posts").document(postID).updateData(["dislikedIDs": FieldValue.arrayRemove([userUID])])
            }else{
                try await Firestore.firestore().collection("Posts").document(postID).updateData(["dislikedIDs": FieldValue.arrayRemove([userUID])])
            }
        }
    }
        
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
