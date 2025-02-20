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
                        metaData: ["markerMetadataKey": "Marker metadata for cluster: \(coordinates.latitude), \(coordinates.longitude)"],
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
            
            GoogleMapWrapper.shared?.mapViewRepresentable

        }
        .padding()
    }
}

#Preview {
    ContentView()
}

public struct GoogleMapView: UIViewRepresentable {
    public class Coordinator: NSObject, GMSMapViewDelegate {}

    public func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    public func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: 52.5200, longitude: 13.4050, zoom: 10)
        let mapView = GMSMapView(frame: .zero, camera: camera)

        // Set delegate to prevent crashes and handle touch events
        mapView.delegate = context.coordinator
        
        return mapView
    }

    public func updateUIView(_ uiView: GMSMapView, context: Context) {}
}

