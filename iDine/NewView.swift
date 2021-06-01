//
//  NewView.swift
//  iDine
//
//  Created by Patrick Pang on 1/6/21.
//

import SwiftUI

struct NewView: View {
    @State private var name = "Apple Smith"
    @State private var snippet: String? = nil
    @State private var isDoneAlertShowing = false
    
    var body: some View {
        VStack {
            TextView(text: $name, insertText: $snippet)
                .border(Color(UIColor.separator))
            
            Text("\(name)")

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
                    snippet = "Hello"
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
    @Binding var insertText: String?
            
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.text = text
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if let insertTextStr = insertText {
            DispatchQueue.main.async {
                var s = insertTextStr,
                    uiRange = uiView.selectedRange,
                    uiText = uiView.text ?? ""
                
                if uiRange.location >= 1, let beforeRange = Range(NSMakeRange(uiRange.location - 1, 1), in: uiText) {
                    if uiText[beforeRange].rangeOfCharacter(from: .whitespaces) == nil {
                        s = " " + s
                    }
                }
                
                if let afterRange = Range(NSMakeRange(uiRange.location + uiRange.length, 1), in: uiText) {
                    if uiText[afterRange].rangeOfCharacter(from: .whitespaces) == nil {
                        s += " "
                    }
                }
                
                uiView.insertText(s)
                insertText = nil
            }
        } else if uiView.text != text {
            uiView.text = text
        }
    }
}

class Coordinator: NSObject, UITextViewDelegate {
    var parent: TextView
    
    init(_ parent: TextView) {
        self.parent = parent
    }
    
    func textViewDidChange(_ textView: UITextView) {
        parent.text = textView.text
    }
}


struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}
