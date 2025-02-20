//
//  ContentView.swift
//  ExampleGoogleMap
//
//  Created by Ankush Kushwaha on 17/02/25.
//

import SwiftUI
import GoogleMapTarget
import GoogleMaps
import GoogleMapsUtils

struct ContentView: View {
    @State var mapView = GoogleMapWrapper.shared!.mapView
    @State var popupText: String? = nil
    
    private let metaDataKey =  "markerMetadataKey"
    
    var body: some View {
        VStack {
            Button("Add Marker") {

                let points = [
                        CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // SF
                        CLLocationCoordinate2D(latitude: 37.7849, longitude: -122.4094), // Another location
                        CLLocationCoordinate2D(latitude: 37.7649, longitude: -122.4294)  // Another location
                    ]
                
                let markersWithData = points.map { coordinates in
                    MarkerWithData(
                        geoCoordinates: coordinates,
                        metaData: [metaDataKey: "Marker metadata for cluster: \(coordinates.latitude), \(coordinates.longitude)"],
                        image: UIImage(systemName: "car.fill")!
                    )
                }
                
                GoogleMapWrapper.shared?.addMarkers(markersWithData)
                
                GoogleMapWrapper.shared!.moveCamera(points.first!)
            }
            
            Button("Add Clusters") {
                
                let points = [
                    CLLocationCoordinate2D(latitude: 52.53032, longitude: 13.37409),
                    CLLocationCoordinate2D(latitude: 52.5309, longitude: 13.3946),
                    CLLocationCoordinate2D(latitude: 52.53894, longitude: 13.39194),
                    CLLocationCoordinate2D(latitude: 52.54014, longitude: 13.37958),
                    CLLocationCoordinate2D(latitude: 52.53150, longitude: 13.38050),
                    CLLocationCoordinate2D(latitude: 52.53500, longitude: 13.38200),
                    CLLocationCoordinate2D(latitude: 52.53275, longitude: 13.38800),
                    CLLocationCoordinate2D(latitude: 52.53720, longitude: 13.37550),
                    CLLocationCoordinate2D(latitude: 52.53460, longitude: 13.39220),
                    CLLocationCoordinate2D(latitude: 52.53380, longitude: 13.37840)
                ]
                
                let markersWithData = points.map { coordinates in
                    MarkerWithData(
                        geoCoordinates: coordinates,
                        metaData: [metaDataKey: "Marker metadata for cluster: \(coordinates.latitude), \(coordinates.longitude)"],
                        image: UIImage(systemName: "car.fill")!
                    )
                }

                GoogleMapWrapper.shared?.addMarkerCluster(
                    markersWithData,
                    clusterImage: UIImage(systemName: "circle.fill")!
                )
                
                GoogleMapWrapper.shared!.moveCamera(points.first!)
            }
            
            
            Button("Add Route") {
                
                let points: [CLLocationCoordinate2D] = [
                    CLLocationCoordinate2D(latitude: 52.5505, longitude: 13.3704), // Gesundbrunnen
                    CLLocationCoordinate2D(latitude: 52.5426, longitude: 13.3499), // Mauerpark
                    CLLocationCoordinate2D(latitude: 52.5294, longitude: 13.4134), // Hackescher Markt
                    CLLocationCoordinate2D(latitude: 52.5208, longitude: 13.4094), // Alexanderplatz
                    CLLocationCoordinate2D(latitude: 52.5186, longitude: 13.3762), // Reichstag Building
                    CLLocationCoordinate2D(latitude: 52.5163, longitude: 13.3777), // Brandenburg Gate
                    CLLocationCoordinate2D(latitude: 52.5097, longitude: 13.3758), // Tiergarten
                    CLLocationCoordinate2D(latitude: 52.5037, longitude: 13.3769), // Potsdamer Platz
                    CLLocationCoordinate2D(latitude: 52.5076, longitude: 13.3904), // Checkpoint Charlie
                    CLLocationCoordinate2D(latitude: 52.4958, longitude: 13.3051), // Charlottenburg Palace
                    CLLocationCoordinate2D(latitude: 52.4854, longitude: 13.4443), // Treptower Park
                    CLLocationCoordinate2D(latitude: 52.4731, longitude: 13.4220), // Tempelhofer Feld
                    CLLocationCoordinate2D(latitude: 52.4701, longitude: 13.3872), // Schöneberg
                    CLLocationCoordinate2D(latitude: 52.4617, longitude: 13.3722), // Rathaus Steglitz
                    CLLocationCoordinate2D(latitude: 52.4550, longitude: 13.2901)  // Wannsee
                ]

                GoogleMapWrapper.shared?.drawRoute(points)
                
                GoogleMapWrapper.shared!.moveCamera(points.first!)
            }
            
            ZStack {
                GoogleMapWrapper.shared?.mapViewRepresentable
                
                if let popupText = popupText, !popupText.isEmpty  {
                    CustomPopupView(text: $popupText)
                }
            }

        }
        .padding()
        .onAppear {
            GoogleMapWrapper.shared?.tapHandler = { marker in
             
                if let cluster = marker.userData as? GMUCluster {
                    
                    popupText = "Cluster contains \(cluster.count) markers"

                    for marker in cluster.items {
                        popupText! += "\n \(marker.position)"
                    }
                    
                } else {
                    
                    popupText = "Marker tapped at position \(marker.position)"

                    if let metadata = marker.userData as? [String: Any] {
                        popupText = popupText! + "\n\n--------\n \(String(describing: metadata[metaDataKey]))"
                    }
                }
                
                if marker.userData is GMUCluster {
                  // zoom in on tapped cluster
                  NSLog("Did tap cluster")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
