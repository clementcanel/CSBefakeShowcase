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
                VStack{
                            Text("Add Your Message").frame(width: 200).background(.white).foregroundColor(.black).cornerRadius(30).padding(.vertical,10)
                    }
                    ScrollView{
                        TextEditor(text: $textMessage)
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .padding()
                            .cornerRadius(30)
                            .foregroundColor(.white)
                            .font(.title)
                            .background(Color(white: 0.3))
                    }
                    Button("Submit Message") {
                        message = textMessage
                        dismiss.callAsFunction()
                        messageClosure?()
                    
                    }.buttonStyle(.borderedProminent)
                    Spacer().frame(height: 400)
                }.padding(.horizontal, 20)
                
                    .background(.black)
                
                    .shadow(radius: 30).foregroundColor(.white)
                
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "arrow.backward").foregroundColor(.white)
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

