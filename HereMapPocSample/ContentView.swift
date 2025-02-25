//
//  ContentView.swift
//  HereMapPocSample
//
//  Created by Ankush Kushwaha on 21/12/24.
//

import SwiftUI
import here_map_package
import heresdk

struct ContentView: View {
    @State private var mapView = HereMapWrapper.shared!.mapView
    
    var body: some View {
        VStack {
            
            Button("Add Marker") {
                HereMapWrapper.shared?.addMarker(
                    GeoCoordinates(
                        latitude: 52.520798,
                        longitude: 13.409408
                    ),
                    image: UIImage(systemName: "car.fill")!
                )
                HereMapWrapper.shared?.moveCamera(GeoCoordinates(
                    latitude: 52.520798,
                    longitude: 13.409408
                ))
            }
            
            Button("Add Route") {
                let startGeoCoordinates = GeoCoordinates(latitude: 52.51087113766646, longitude: 13.396939881800781)
                let destinationGeoCoordinates = GeoCoordinates(latitude: 52.53595152570505, longitude: 13.425996387349484)
                HereMapWrapper.shared?.darwRoute(start: startGeoCoordinates, end: destinationGeoCoordinates)
                    
                HereMapWrapper.shared?.moveCamera(startGeoCoordinates)
            }
            
            Button("Clear Map") {
                HereMapWrapper.shared?.clearMap()
            }
            
            MapViewUIRepresentable(mapView: $mapView)
                .edgesIgnoringSafeArea(.all)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


 let ACCESS_KEY_ID = "nzK5NTVRrBB7zoixWk5puw"
 let ACCESS_KEY_SECRET = "VZ5aGmGSZ9zFQR87D8eH6tEFWv2BhoKp4D-YX0C4kEEykIEUQvh_GnrHoW5X_GWzl3cN118kI_3YX0Dlk_4TVQ"
