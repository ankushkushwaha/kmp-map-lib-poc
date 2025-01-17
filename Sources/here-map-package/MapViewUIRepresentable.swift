//
//  File.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 20/12/24.
//

import heresdk
import SwiftUI

public
struct MapViewUIRepresentable: UIViewRepresentable {
    @Binding var mapView: MapView

    public init(mapView: Binding<MapView>) {
        self._mapView = mapView
    }
    
    public func makeUIView(context: Context) -> MapView { return mapView }
    public func updateUIView(_ mapView: MapView, context: Context) { }
}
