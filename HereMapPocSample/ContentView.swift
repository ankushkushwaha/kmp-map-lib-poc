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
    
    init() {
//        self.mapView = HereMapWrapper.shared?.mapView ?? MapView()
    }
    
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
                
                HereMapWrapper.shared?.add(
                    GeoCoordinates(
                        latitude: 52.520798,
                        longitude: 13.409408
                    ),
                    image: UIImage(systemName: "car.fill")!
                )
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
