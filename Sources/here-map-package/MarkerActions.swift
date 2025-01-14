//
//  File.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 14/01/25.
//

import Foundation
import heresdk
import UIKit

class MarkerActions {
 
    private let mapView: MapView
    private var mapMarkers = [MapMarker]()

    init(_ mapView: MapView) {
        self.mapView = mapView
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
        
        mapMarkers.append(mapMarker)
    }
    
    @MainActor public func clearMarkers() {
        for mapMarker in mapMarkers {
            mapView.mapScene.removeMapMarker(mapMarker)
        }
        mapMarkers.removeAll()
    }
}
