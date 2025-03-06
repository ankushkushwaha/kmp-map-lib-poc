//
//  CustomPopupView.swift
//  HereMapPocSample
//
//  Created by Ankush Kushwaha on 16/01/25.
//

import SwiftUI
import heresdk

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
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    let imageData = UIImage(systemName: "car.fill")?.pngData()
    
    let mapImage = MapImage(pixelData: imageData!,
                            imageFormat: ImageFormat.png)
    CustomPopupView(text: .constant("Title"))
}
