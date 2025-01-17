//
//  CustomPopupView.swift
//  HereMapPocSample
//
//  Created by Ankush Kushwaha on 16/01/25.
//

import SwiftUI
import heresdk

struct CustomPopupView: View {
    let marker: MapMarker
    let metaData: String
    @Binding var showPopup: Bool
    
    var body: some View {
        VStack {
            Text("Marker tapped!")
                .padding()

            Text("Location: \(marker.coordinates.latitude), \(marker.coordinates.longitude)")
                .padding()
            
            Text("Metadata: \(metaData)")
                .padding()

            Button("Close") {
                showPopup = false
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
    CustomPopupView(marker: MapMarker(at: GeoCoordinates(latitude: 0.0, longitude: 0.0), image: mapImage), metaData: "Test", showPopup: .constant(true))
}
