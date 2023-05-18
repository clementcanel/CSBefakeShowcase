
//  ContentView.swift
//  BeFakef1
//
//  Created by Elijah Senior on 4/17/23.


import SwiftUI

struct ContentView: View {
    
    @State var logStatus: Bool = false
    @StateObject var fbService = FireBaseService()
    // Tried to connect to login view using this
    var body: some View {
        if logStatus{
            MainView().environmentObject(fbService)
        }else{
            LoginView(logStatus: $logStatus).environmentObject(fbService) // try this
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
