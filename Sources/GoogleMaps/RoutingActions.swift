//
//  File.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 18/02/25.
//

import Foundation
import GoogleMaps

public struct RoutingActions {
    private var mapView: GMSMapView

    public init(_ mapView: GMSMapView) {
        self.mapView = mapView
    }
    
    func addRoute(points: [CLLocationCoordinate2D]) {
        let path = GMSMutablePath()
        
        for point in points {
            path.add(point)
        }

        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .blue
        polyline.strokeWidth = 5
        polyline.map = mapView
    }
}
