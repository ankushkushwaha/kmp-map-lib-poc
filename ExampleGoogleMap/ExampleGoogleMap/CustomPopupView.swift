//
//  CustomPopupView.swift
//  ExampleGoogleMap
//
//  Created by Ankush Kushwaha on 20/02/25.
//


import SwiftUI
//import heresdk

struct CustomPopupView: View {
    @Binding var text: String?
    
    var body: some View {
        VStack {
            ScrollView {
                Text(text ?? "")
                    .padding()
            }
            .frame(maxHeight: 300)

            Button("Close") {
                text = nil
            }
            .padding()
        }
        .frame(width: 200)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    CustomPopupView(text: .constant("Title"))
}
