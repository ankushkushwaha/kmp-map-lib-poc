//
//  CameraAction.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 17/02/25.
//

import GoogleMaps

class CameraAction {
    
    private weak var mapView: GMSMapView?
    
    init(_ mapView: GMSMapView) {
        self.mapView = mapView
    }
    
    @MainActor func moveCamera(to point: CLLocationCoordinate2D, zoomLevel: Float = 11.0) {
        let camera = GMSCameraPosition(latitude: point.latitude, longitude: point.longitude, zoom: zoomLevel)
        mapView?.animate(to: camera)
    }
}

