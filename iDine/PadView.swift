//
//  PadView.swift
//  iDine
//
//  Created by Patrick Pang on 5/6/21.
//

import SwiftUI

struct PadView: View {
    var body: some View {
        NavigationView {
            List(1..<5) { i in
                Text("Item \(i)")
            }
            Text("Hello")
        }
    }
}

struct PadView_Previews: PreviewProvider {
    static var previews: some View {
        PadView()
            
    }
}
