//
//  File.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 17/02/25.
//

import Foundation
import GoogleMaps

public struct MarkerActions {
    
    private let mapView: GMSMapView
    private var mapMarkers = [GMSMarker]()
    
    init(_ mapView: GMSMapView) {
        self.mapView = mapView
    }
    
    public func addMarkers(_ markers: [CLLocationCoordinate2D]) {
        for markerCoordinate in markers {
            let marker = GMSMarker()
            marker.position = markerCoordinate
            marker.map = mapView
        }
    }
}
