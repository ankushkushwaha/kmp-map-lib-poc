//
//  File.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 14/01/25.
//

import Foundation
@preconcurrency import heresdk
import UIKit

struct MarkerActions {
    
    private let mapView: MapView
    
    @MainActor
    init(_ mapView: MapView) {
        self.mapView = mapView
        
        // Load the map scene using a map scheme to render the map with.
        mapView.mapScene.loadScene(mapScheme: MapScheme.normalDay, completion: onLoadScene)
    }
    
    @MainActor
    private func onLoadScene(mapError: MapError?) {
        guard mapError == nil else {
            print("Error: Map scene not loaded, \(String(describing: mapError))")
            return
        }
        // Optionally, enable low speed zone map layer.
        mapView.mapScene.enableFeatures([MapFeatures.lowSpeedZones : MapFeatureModes.lowSpeedZonesAll]);
    }
    
    
    @MainActor func addMarker(_ point: GeoCoordinates, image: UIImage) {
        guard let imageData = image.pngData() else {
            print("Error: Image not found.")
            return
        }
        
        let mapImage = MapImage(pixelData: imageData,
                                imageFormat: ImageFormat.png)
        
        let mapMarker = MapMarker(at: point, image: mapImage)
        
        
        mapView.mapScene.addMapMarker(mapMarker)
        
        setCamera(point)
    }
    
    @MainActor
    func setCamera(_ point: GeoCoordinates) {
        let camera = mapView.camera
        let distanceInMeters = MapMeasure(kind: .distance, value: 1000 * 10)
        camera.lookAt(point: point,
                      zoom: distanceInMeters)
    }
    
}
