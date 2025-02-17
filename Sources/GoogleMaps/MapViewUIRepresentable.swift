//
//  GoogleMapsView.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 17/02/25.
//
import UIKit
import SwiftUI
import GoogleMaps

public struct MapViewUIRepresentable: UIViewControllerRepresentable {

    @Binding var mapView: GMSMapView
    
    public init(mapView: Binding<GMSMapView>) {
        self._mapView = mapView
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let camera = GMSCameraPosition(latitude: 37.7749, longitude: -122.4194, zoom: 12.0)
        mapView.camera = camera
        // Enable user location
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        viewController.view = mapView
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Can update camera position or markers here if needed
    }
}
