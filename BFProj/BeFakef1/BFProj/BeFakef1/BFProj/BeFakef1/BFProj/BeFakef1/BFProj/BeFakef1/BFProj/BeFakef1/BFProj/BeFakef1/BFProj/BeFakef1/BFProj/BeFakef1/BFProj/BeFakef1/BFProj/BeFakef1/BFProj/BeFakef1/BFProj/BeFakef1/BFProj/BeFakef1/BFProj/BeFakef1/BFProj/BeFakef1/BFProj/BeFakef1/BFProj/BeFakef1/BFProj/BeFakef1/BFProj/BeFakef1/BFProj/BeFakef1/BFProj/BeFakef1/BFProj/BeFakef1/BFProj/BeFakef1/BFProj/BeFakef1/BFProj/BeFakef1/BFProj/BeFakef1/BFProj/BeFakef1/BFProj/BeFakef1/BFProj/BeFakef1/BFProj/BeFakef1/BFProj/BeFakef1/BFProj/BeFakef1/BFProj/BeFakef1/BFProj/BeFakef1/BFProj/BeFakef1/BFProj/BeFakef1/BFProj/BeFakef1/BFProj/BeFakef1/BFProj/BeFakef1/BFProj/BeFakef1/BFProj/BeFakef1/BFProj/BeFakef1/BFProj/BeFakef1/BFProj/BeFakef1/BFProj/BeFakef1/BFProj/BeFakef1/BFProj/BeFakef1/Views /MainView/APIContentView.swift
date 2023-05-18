//
//  APIContentView.swift
//  BeFakef1
//
//  Created by Elijah Senior on 5/5/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct APIContentView: View {
    
    @ObservedObject var randomImages = UnsplashData()
    var body: some View {
        ScrollView{
            LazyVStack (alignment: .leading){
            ForEach(randomImages.photoArray, id: \.id) { photo in
                WebImage(url: URL(string: photo.urls["thumb"]!))
                    .resizable()
                    .frame(width: 400, height: 400)
            }
        }}
        .preferredColorScheme(.dark)

    }
        }

struct APIContentView_Previews: PreviewProvider {
    static var previews: some View {
        APIContentView()
    }
}
