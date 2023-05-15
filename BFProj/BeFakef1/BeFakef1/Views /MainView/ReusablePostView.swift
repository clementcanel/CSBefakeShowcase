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
                      
                        Posts()
                    }
                }
            }
            .refreshable {
                isFetching = true
                posts = []
                await fetchPosts()
            }
            .task {
                guard posts.isEmpty else{return}
                await fetchPosts()
            }
        }
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    func Posts()->some View{
        ForEach(posts){post in
            PostCardView(post: post) { updatePost in
               
            } onDelete: {
               
            }
            Divider()
        }
    }
    
    func fetchPosts()async{
        do{
            var query: Query
            query = Firestore.firestore().collection("Posts")
                .order(by: "publishedDate", descending: true)
                .limit(to: 20)
            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> Post? in
                try? doc.data(as: Post.self)
            }
            await MainActor.run(body: {
                posts = fetchedPosts
                isFetching = false
            })
        }catch{
            print(error.localizedDescription)
        }
    }
}

struct ReusablePostView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
