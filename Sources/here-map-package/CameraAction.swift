//
//  CameraAction.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 14/01/25.
//

import Foundation
import heresdk

class CameraAction {
    
    private let mapView: MapView
    
    init(_ mapView: MapView) {
        self.mapView = mapView
    }
    
    @MainActor func moveCamera(_ point: GeoCoordinates) {
        let camera = mapView.camera
        let distanceInMeters = MapMeasure(kind: .distance, value: 1000 * 10)
        camera.lookAt(point: point,
                      zoom: distanceInMeters)
    }
    
}
