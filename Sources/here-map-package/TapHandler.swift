//
//  TapHandler.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 16/01/25.
//
import heresdk

class TapHandler: @preconcurrency TapDelegate {
    public var markerTapped: ((MapMarker) -> Void)?
    
    private let mapView: MapView

    @MainActor
    init(_ mapView: MapView) {
        self.mapView = mapView
        mapView.gestures.tapDelegate = self
    }
    

    @MainActor public func onTap(origin: Point2D) {
        mapView.pickMapItems(at: origin, radius: 2, completion: onMapItemsPicked)
    }

    func onMapItemsPicked(pickedMapItems: PickMapItemsResult?) {
        guard let topmostMapMarker = pickedMapItems?.markers.first else {
            return
        }
        markerTapped?(topmostMapMarker)
    }
}
