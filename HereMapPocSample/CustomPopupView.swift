//
//  CustomPopupView.swift
//  HereMapPocSample
//
//  Created by Ankush Kushwaha on 16/01/25.
//

import SwiftUI
import heresdk

struct CustomPopupView: View {
//    let marker: MapMarker
    @Binding var showPopup: Bool
    
    var body: some View {
        VStack {
            Text("Marker tapped!")
//            Text("Location: \(marker.coordinates.latitude), \(marker.coordinates.longitude)")
//                .padding()
            Button("Close") {
                showPopup = false
            }
        }
        .frame(width: 200, height: 150)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
//    let imageData = UIImage(systemName: "car.fill")?.pngData()
//    
//    let mapImage = MapImage(pixelData: imageData!,
//                            imageFormat: ImageFormat.png)
//    CustomPopupView(marker: MapMarker(at: GeoCoordinates(latitude: 0.0, longitude: 0.0), image: mapImage))
}
