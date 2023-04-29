//
//  MainView.swift
//  BeFakef1
//
//  Created by Elijah Senior on 4/17/23.
//

import SwiftUI

struct MainView: View {
//Supposed to connect after successful login
    var body: some View {
       
            TabView{
                Text("BeFakePosts.")
                    .tabItem {
                        Image(systemName: "photo.fill.on.rectangle.fill")
                        Text("posts")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.and.background.dotted")
                        Text("profile")
                    }
            }
            .tint(.gray)
        }
    }

    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
    }

