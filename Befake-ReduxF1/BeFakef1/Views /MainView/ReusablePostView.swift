//
//  ReusablePostView.swift
//  BeFakef1
//
//  Created by Elijah Senior on 5/3/23.
//

import SwiftUI
import Firebase

struct ReusablePostView: View {
    @Binding var posts: [Post]
    @State var isFetching: Bool = false
    @State var likedCount = 0
    @State var selectedItem: String? = nil
    @State var showMessage = false
    @State var tagged = false
    @State var messages:String
    @State var selectedPost: Post?
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack{
                if isFetching {
                    ProgressView()
                        .padding(.top,30)
                }else{
                    if posts.isEmpty{
                        Text("Make some friends dude.")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    }else{
                        ForEach(0..<posts.count, id: \.self){i in
                            
                            PostCardView(post: posts[i], message: $messages, tagged: $tagged, likedPostCount: likedCount) {
                                        var post = posts[i]
                                        post.likedIDs.append(post.userUID)
                                post.comments = messages
                                post.tag = tagged
                                
                                    post.likedCount += 1
                                
                                    likedCount = post.likedCount
                                    posts[i] = post
                                    likePost(post: post, userUID: post.userUID, postIDs: post.id)
                                   messages = post.comments
                                   selectedPost = posts[i]
                                    saveMessgeToPost(userUID: post.userUID, post: post, postIDs: post.id)
                                tagPost(userUID: post.userUID, post: post, postIDs: post.id)
                                }dislikeClosure: {
                                    posts[i].likedCount -= 1
                                    likedCount = posts[i].likedCount
                                   dislikePost(post: posts[i], userUID: posts[i].userUID)
                                }tagClosure: {
                                    tagged = !tagged
                                    posts[i].tag = tagged
                                    selectedPost = posts[i]
                                    tagPost(userUID: posts[i].userUID, post: posts[i], postIDs: posts[i].id)
                                }messageClosure: {
                                    selectedPost = posts[i]
                                    showMessage.toggle()
                                }
                        
                            Divider()
                        }.onChange(of: likedCount) { newValue in
                            fetchPosts()
                        }
                        .onChange(of: tagged, perform: { newValue in
                            fetchPosts()
                        })
                        .onChange(of: messages, perform: { newValue in
                            fetchPosts()
                        })
                        .refreshable {
                           fetchPosts()
                        }
                    }
                }
            }
            .listStyle(.plain)
            .refreshable {
                isFetching = true
             
                fetchPosts()
            }
            .task {
                guard posts.isEmpty else{return}
               fetchPosts()
            }.onAppear{
               
                    fetchPosts()
                
            }
            .fullScreenCover(isPresented: $showMessage, onDismiss: {
                Task{
                    guard var selectedPost = selectedPost else {return}
                    selectedPost.comments = messages
                    saveMessgeToPost(userUID: selectedPost.userUID, post: selectedPost, postIDs: selectedPost.id)
                    fetchPosts()
                }
            }) {
                MessageView(message: $messages) {
                    Task{
                        guard var selectedPost = selectedPost else {return}
                        selectedPost.comments = messages
                
                        saveMessgeToPost(userUID: selectedPost.userUID, post: selectedPost, postIDs: selectedPost.id)
                        fetchPosts()
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    func saveMessgeToPost(userUID: String, post:Post, postIDs:String?) {
        Task{
            guard let postID = postIDs else {return}
            try await FireBaseService.shared.postToFirebase(postID: postID, userUID: userUID, data: ["comments": messages])
        }
    }
    
    func tagPost(userUID: String, post:Post, postIDs:String?) {
        Task{
            guard let postID = postIDs else {return}
            try await FireBaseService.shared.postToFirebase(postID: postID, userUID: userUID, data: ["tag": tagged])
        }
    }
    
    func likePost(post: Post, userUID: String, postIDs:String?){
        Task{
            guard let postID = postIDs else {return}
            
            if post.likedIDs.contains(userUID){
                try await FireBaseService.shared.postToFirebase(postID: postID, userUID: userUID, data: ["likedIDs": FieldValue.arrayUnion([userUID])])
                try await FireBaseService.shared.postToFirebase(postID: postID, userUID: userUID, data: ["likedCount": likedCount])

            }else{
                try await FireBaseService.shared.postToFirebase(postID: postID, userUID: userUID, data: ["likedIDs": FieldValue.arrayUnion([userUID])])
                try await FireBaseService.shared.postToFirebase(postID: postID, userUID: userUID, data: ["likedCount": likedCount])
              
            }
        }
    }
    
    func dislikePost(post: Post, userUID: String){
        Task{
            guard let postID = post.id else{return}
            if post.dislikedIDs.contains(userUID){
                try await FireBaseService.shared.postToFirebase(postID: postID, userUID: userUID, data: ["dislikedIDs": FieldValue.arrayRemove([userUID])])
                try await FireBaseService.shared.postToFirebase(postID: postID, userUID: userUID, data: ["likedCount": likedCount])
                
            }else{
                try await FireBaseService.shared.postToFirebase(postID: postID, userUID: userUID, data: ["dislikedIDs": FieldValue.arrayRemove([userUID])])
                try await FireBaseService.shared.postToFirebase(postID: postID, userUID: userUID, data: ["likedCount": likedCount])
                
            }
        }
    }
    
   
  
    @MainActor
    func fetchPosts() {
        Task{
            do {
                let fetchedPosts = try await FireBaseService.shared.fetchPosts()
                
               
                    posts = fetchedPosts
                    isFetching = false
                
            }catch {
                print("Failed to load")
            }
            
        }
    }

}

struct ReusablePostView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
