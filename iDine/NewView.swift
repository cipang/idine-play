//
//  NewView.swift
//  iDine
//
//  Created by Patrick Pang on 1/6/21.
//

import SwiftUI

struct NewView: View {
    @State private var name = "Apple Smith"
    @State private var isDoneAlertShowing = false
    
    var body: some View {
        VStack {
            TextField("Your Name", text: $name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button {
                isDoneAlertShowing = true
            } label: {
                Text("I am done!").padding(20)
            }
            .contentShape(Rectangle())
        }
        .alert(isPresented: $isDoneAlertShowing) {
            Alert(title: Text("Your Input"), message: Text(name), dismissButton: .default(Text("Done")))
        }
    }
}

struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}
