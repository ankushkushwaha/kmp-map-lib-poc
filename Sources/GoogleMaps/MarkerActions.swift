//
//  File.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 17/02/25.
//

import Foundation
import GoogleMaps
import GoogleMapsUtils

public class MarkerActions: NSObject {
    
    private weak var mapView: GMSMapView?
    public var tapHandler: ((GMSMarker) -> Void)?
    
    private var mapMarkers = [GMSMarker]()
    private var clusterMarkers = [GMSMarker]()
    private let clusterManager: GMUClusterManager

    init(_ mapView: GMSMapView) {
        self.mapView = mapView
        self.clusterManager = GMUClusterManager(
            map: mapView,
            algorithm: GMUNonHierarchicalDistanceBasedAlgorithm(),
            renderer: GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: GMUDefaultClusterIconGenerator())
        )
    }
    
    public func addMarkers(_ markers: [MarkerWithData]) {
        for markerWithData in markers {
            let marker = GMSMarker(position: markerWithData.geoCoordinates)
            marker.map = mapView
            marker.userData = markerWithData.metaData
            mapMarkers.append(marker)
        }
        
        mapView?.delegate = self
    }
    
    public func addClusterMarkers(_ markers: [MarkerWithData]) {
        var arr: [GMSMarker] = []
        for markerWithData in markers {
            let marker = GMSMarker(position: markerWithData.geoCoordinates)
            marker.userData = markerWithData.metaData
            arr.append(marker)
        }
        clusterManager.add(arr)
        clusterManager.setMapDelegate(self)
    }
}

extension MarkerActions: GMSMapViewDelegate, GMUClusterManagerDelegate {
    
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        tapHandler?(marker)
        
        // center the map on tapped marker
        mapView.animate(toLocation: marker.position)
        
        return false
    }
}
