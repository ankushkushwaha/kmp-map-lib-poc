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
    
    private let mapView: GMSMapView
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
    
    public func addMarkers(_ markers: [CLLocationCoordinate2D]) {
        for markerCoordinate in markers {
            let marker = GMSMarker(position: markerCoordinate)
            marker.map = mapView
            
            mapMarkers.append(marker)
        }
    }
    
    
    public func addClusterMarkers(_ points: [CLLocationCoordinate2D]) {
        var arr: [GMSMarker] = []
        for markerCoordinate in points {
            let marker = GMSMarker(position: markerCoordinate)
            arr.append(marker)
        }
        clusterManager.add(arr)
        clusterManager.setMapDelegate(self)
    }
    
    
}

extension MarkerActions: GMSMapViewDelegate  {
   
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
      // center the map on tapped marker
      mapView.animate(toLocation: marker.position)
      // check if a cluster icon was tapped
      if marker.userData is GMUCluster {
        // zoom in on tapped cluster
        mapView.animate(toZoom: mapView.camera.zoom + 1)
        NSLog("Did tap cluster")
        return true
      }

      NSLog("Did tap a normal marker")
      return false
    }
          
          
}
