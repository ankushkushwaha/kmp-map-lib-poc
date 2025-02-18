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
                    CLLocationCoordinate2D(latitude: 53.5511, longitude: 9.9937),  // Hamburg
                    CLLocationCoordinate2D(latitude: 52.5200, longitude: 13.4050), // Berlin
                    CLLocationCoordinate2D(latitude: 51.0504, longitude: 13.7373), // Dresden
                    CLLocationCoordinate2D(latitude: 50.9375, longitude: 6.9603),  // Cologne
                    CLLocationCoordinate2D(latitude: 50.1109, longitude: 8.6821),  // Frankfurt
                    CLLocationCoordinate2D(latitude: 48.1351, longitude: 11.5820), // Munich
                    CLLocationCoordinate2D(latitude: 47.3769, longitude: 8.5417),  // Zurich (Switzerland)
                    CLLocationCoordinate2D(latitude: 46.2044, longitude: 6.1432),  // Geneva (Switzerland)
                    CLLocationCoordinate2D(latitude: 45.4642, longitude: 9.1900),  // Milan (Italy)
                    CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964)  // Rome (Italy)
                ]
                GoogleMapWrapper.shared?.drawRoute(points)
                
                GoogleMapWrapper.shared!.moveCamera(points.first!)
            }
            
            GoogleMapWrapper.shared?.mapViewRepresentable
//            MapViewUIRepresentable(mapView: $mapView)
            
//            GoogleMapView().ignoresSafeArea()
            
//            GoogleMapView2(mapView: $mapView).ignoresSafeArea()

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

