//
//  File.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 20/12/24.
//

import heresdk
import SwiftUI

@available(iOS 13.0, *)
struct MapViewUIRepresentable: UIViewRepresentable {

    // Conform to UIViewRepresentable protocol.
    func makeUIView(context: Context) -> MapView {
        // Create an instance of the map view.
        return MapView()
    }

    // Conform to UIViewRepresentable protocol.
    func updateUIView(_ mapView: MapView, context: Context) {
        // Load the map scene using a map scheme to render the map with.
        mapView.mapScene.loadScene(mapScheme: MapScheme.normalDay, completion: onLoadScene)

        // Inlined completion handler for onLoadScene().
        func onLoadScene(mapError: MapError?) {
            guard mapError == nil else {
                print("Error: Map scene not loaded, \(String(describing: mapError))")
                return
            }

            // Use the camera to specify where to look at the map.
            // For this example, we show Berlin in Germany.
            let camera = mapView.camera
            let distanceInMeters = MapMeasure(kind: .distance, value: 1000)
            camera.lookAt(point: GeoCoordinates(latitude: 52.517543, longitude: 13.408991),
                          zoom: distanceInMeters)
        }
    }

}
