//
//  GoogleMapsView.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 17/02/25.
//
import UIKit
import SwiftUI
import GoogleMaps

public struct MapRepresentable: UIViewRepresentable {
      
    public var mapCreated: ((GMSMapView) -> Void)?

    public class Coordinator: NSObject, GMSMapViewDelegate {}

    public func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    public func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView(frame: .zero)

//        mapView.delegate = context.coordinator
        
        mapCreated?(mapView)
        return mapView
    }

    public func updateUIView(_ uiView: GMSMapView, context: Context) {}
}
