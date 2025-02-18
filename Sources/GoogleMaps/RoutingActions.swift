//
//  File.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 18/02/25.
//

import Foundation

struct RoutingAction {
    private var mapView: MapView

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
