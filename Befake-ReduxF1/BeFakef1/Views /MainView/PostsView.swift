//
//  PostsView.swift
//  BeFakef1
//
//  Created by Elijah Senior on 5/2/23.
//

import SwiftUI

struct PostsView: View {
    @State private var recentPosts: [Post] = []
    @State private var createNewPost: Bool = false
    @State var message:String
    var body: some View {
        NavigationStack{
            ReusablePostView(posts: $recentPosts, messages: message)
                .hAlign(.center).vAlign(.center)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .overlay(alignment: .bottomTrailing){
                    Button {
                        createNewPost.toggle()
                    } label: {
                        Image(systemName: "plus.square.fill.on.square.fill")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(13)
                            .background(.black, in: (RoundedRectangle(cornerRadius: 10, style: .continuous)))
                            
                    }
                    .padding(15)
                }
                .navigationTitle("FakePosts.")
        }
        .fullScreenCover(isPresented: $createNewPost) {
            CreateNewPost { post in
                recentPosts.insert(post, at: 0)
            }
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView(message: "")
    }
}
