//
//  GoogleMapsView.swift
//  ExampleGoogleMap
//
//  Created by Ankush Kushwaha on 17/02/25.
//


import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let camera = GMSCameraPosition(latitude: 37.7749, longitude: -122.4194, zoom: 12.0)
        let mapView = GMSMapView(frame: .zero, camera: camera)
        
        // Enable user location
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        viewController.view = mapView
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Can update camera position or markers here if needed
    }
}
