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
    @Binding var message: String
    @Binding var tagged: Bool
    @State private var docListener: ListenerRegistration?
    @State var likedPostCount: Int
    var closure:(()->Void)?
    var dislikeClosure:(()->Void)?
    var tagClosure:(()->Void)?
    var messageClosure:(()->Void)?
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
                    
                    HStack(spacing: 20){
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
                        Button{
                            tagClosure?()
                        }label: {
                            Image(systemName: post.tag ? "tag.fill": "tag")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                               
                        }
                        
                        Button {
                            messageClosure?()
                        } label: {
                            Image(systemName: "bubble.right")
                                .resizable()
                                .frame(width: 20,height: 20)
                                .foregroundColor(.white)
                        }
                        
                        
                    }
                }
                    Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
                        .font(.caption2)
                        .fontWeight(.light)
                        .foregroundColor(.yellow)
                if !post.comments.isEmpty{
                    VStack{
                        Text(post.comments).multilineTextAlignment(.center)
                            .lineLimit(0)
                            .foregroundColor(.white)
                    }.frame(height: 50).background(.black)
                }
                
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
