//
//  ContentView.swift
//  ExampleGoogleMap
//
//  Created by Ankush Kushwaha on 17/02/25.
//

import SwiftUI
import GoogleMapTarget
import GoogleMaps

struct ContentView: View {
    @State var mapView = GoogleMapWrapper.shared!.mapView
    
    var body: some View {
        VStack {
            Button("Add Marker") {
                
                let markerCoordinates = [
                        CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // SF
                        CLLocationCoordinate2D(latitude: 37.7849, longitude: -122.4094), // Another location
                        CLLocationCoordinate2D(latitude: 37.7649, longitude: -122.4294)  // Another location
                    ]
                
                GoogleMapWrapper.shared?.addMarkers(markerCoordinates, image: nil, metaDataDict: nil)
                
                GoogleMapWrapper.shared!.moveCamera(markerCoordinates.first!)
            }
            
            MapViewUIRepresentable(mapView: $mapView)

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
