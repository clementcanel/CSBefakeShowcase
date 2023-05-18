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
    
    @AppStorage("user_UID") private var userUID: String = ""
    
    @State private var docListener: ListenerRegistration?
    @State var likedPostCount: Int
    var closure:(()->Void)?
    var dislikeClosure:(()->Void)?
    
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
                  
                        HStack(spacing: 8){
                            Button {
                                closure?()
                            } label: {
                                Image(systemName: post.likedIDs.contains(userUID) ? "heart.fill" : "heart")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.white)
                            }.onLongPressGesture {
                                dislikeClosure?()
                            }
                            Text("\(post.likedCount)")
                                .font(.callout)
                                .foregroundColor(.gray)
                            
                        }
                        
                }
                    Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
                        .font(.caption2)
                        .fontWeight(.light)
                        .foregroundColor(.yellow)
                    
                
            }
            
        }
        .hAlign(.leading)
        .onChange(of: post.likedIDs.count) { newValue in
            likedPostCount = newValue
        }
      
    }
        
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
