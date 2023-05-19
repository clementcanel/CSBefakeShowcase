//
//  MessageView.swift
//  BeFakef1
//
//  Created by Clement Canel on 5/18/23.
//
import SwiftUI

struct MessageView: View {
    @State var textMessage = ""
    @Environment(\.dismiss) var dismiss
    @Binding var message: String
    var messageClosure:(()->Void)?
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack(alignment:.center){
                    VStack {
                        Text("Add Your Short Comment")
                            .frame(width: 300)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .bold))
                            .cornerRadius(30)
                            .padding(.vertical, 10)

                        Text("Drag Right Under For View")
                            .frame(width: 300)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .cornerRadius(30)
                            .padding(.vertical, 0)
                            .fontWeight(.thin)
                    }

                    ScrollView{
                        TextEditor(text: $textMessage)
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .padding()
                            .font(.system(size: 14, weight: .bold))
                            .cornerRadius(30)
                            .background(Color(white: 0.3))
                    }
                    Button("Submit Comment") {
                        message = textMessage
                        dismiss.callAsFunction()
                        messageClosure?()
                        
                    }.buttonStyle(.borderedProminent)
                    Spacer().frame(height: 150)
                    
                }.padding(.horizontal, 20)
                
                    .background(.black)
                
                    .shadow(radius: 30).foregroundColor(.white)
                
            }
            Text("BeFake.")
                .multilineTextAlignment(.center)
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding(.top,10)
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "arrow.backward").foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(textMessage: "", message: .constant(""))
    }
}

