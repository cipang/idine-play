//
//  NewView.swift
//  iDine
//
//  Created by Patrick Pang on 1/6/21.
//

import SwiftUI

struct NewView: View {
    @State private var name = "Apple Smith"
    @State private var selection: NSRange = NSRange()
    @State private var isDoneAlertShowing = false
    
    var body: some View {
        VStack {
            TextView(text: $name, selection: $selection)
                .border(Color.black)
            
            Text("\(name)")
            
            Text(NSStringFromRange(selection))

            HStack {
                Button {
                    isDoneAlertShowing = true
                } label: {
                    Text("Show Data").padding()
                }
                
                Button("Reset") {
                    name = "John Appleseed"
                }
                .padding()
                
                Button("Insert") {
                    let r = "Hello"
                    let s = name.replacingCharacters(in: Range(selection, in: name)!, with: r)
                    name = s
                    selection = NSMakeRange(selection.location + r.count, 0)
                }
                .padding()
            }
        }
        .alert(isPresented: $isDoneAlertShowing) {
            Alert(title: Text("Your Input"), message: Text(name), dismissButton: .default(Text("Done")))
        }
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var selection: NSRange
            
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, selection: $selection)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.text = text
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        if uiView.selectedRange != selection {
            uiView.selectedRange = selection
        }
    }
}

class Coordinator: NSObject, UITextViewDelegate {
    var text: Binding<String>
    var selection: Binding<NSRange>
    
    init(text: Binding<String>, selection: Binding<NSRange>) {
        self.text = text
        self.selection = selection
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        self.selection.wrappedValue = textView.selectedRange
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.text.wrappedValue = textView.text
    }
}


struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}
