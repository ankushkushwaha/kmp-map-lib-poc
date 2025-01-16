//
//  HereMapWrapper.swift
//  MyPackage
//
//  Created by Ankush Kushwaha on 20/12/24.
//

import Foundation
import heresdk
import UIKit

public class HereMapWrapper: @preconcurrency MapController {
    
    nonisolated(unsafe) public static var shared: HereMapWrapper?
    
    public let mapView: MapView
    private let markerActions: MarkerActions
    private let cameraAction: CameraAction
    private let routingAction: RoutingActions

    @MainActor public static func configure(accessKeyID: String, accessKeySecret: String) {
        guard shared == nil else {
            fatalError("HereMapWrapper is already configured.")
        }
        shared = HereMapWrapper(accessKeyID: accessKeyID, accessKeySecret: accessKeySecret)
    }
    
    @MainActor public func clearMap() {
        routingAction.clearRoute()
        markerActions.clearMarkers()
    }
    
    @MainActor public func addMarker(_ point: GeoCoordinates, image: UIImage) {
        markerActions.addMarker(point, image: image)
    }
    
    @MainActor public func moveCamera(_ point: GeoCoordinates) {
        cameraAction.moveCamera(point)
    }
    
    @MainActor public func darwRoute(start: GeoCoordinates,
                              end: GeoCoordinates, routeColor: UIColor = .red, widthInPixels: CGFloat = 20.0) {
        routingAction.darwRoute(
            start: start,
            end: end,
            routeColor : routeColor,
            widthInPixels: widthInPixels
        )
    }
    
    @MainActor public func drawRoute(_ points: [heresdk.GeoCoordinates]) {
        routingAction.drawRouteFromPoints(points: points)
    }
        
    @MainActor
    public init(accessKeyID: String,
                accessKeySecret: String) {
        
        let authenticationMode = AuthenticationMode.withKeySecret(
            accessKeyId: accessKeyID,
            accessKeySecret: accessKeySecret
        )
        let options = SDKOptions(
            authenticationMode: authenticationMode
        )
        do {
            try SDKNativeEngine.makeSharedInstance(options: options)
        } catch let engineInstantiationError {
            fatalError("Failed to initialize the HERE SDK. Cause: \(engineInstantiationError)")
        }
        
        self.mapView = MapView()
        self.markerActions = MarkerActions(mapView)
        self.cameraAction = CameraAction(mapView)
        self.routingAction = RoutingActions(mapView)

        // Load the map scene using a map scheme to render the map with.
        mapView.mapScene.loadScene(mapScheme: MapScheme.normalDay, completion: onLoadScene)
        mapView.gestures.tapDelegate = self

    }
    
    @MainActor private func onLoadScene(mapError: MapError?) {
        guard mapError == nil else {
            print("Error: Map scene not loaded, \(String(describing: mapError))")
            return
        }
        
        // Optionally, enable low speed zone map layer.
        mapView.mapScene.enableFeatures([MapFeatures.lowSpeedZones : MapFeatureModes.lowSpeedZonesAll]);
    }
}

extension HereMapWrapper: @preconcurrency TapDelegate {

    @MainActor public func onTap(origin: Point2D) {
        mapView.pickMapItems(at: origin, radius: 2, completion: onMapItemsPicked)
    }

    func onMapItemsPicked(pickedMapItems: PickMapItemsResult?) {
        guard let topmostMapMarker = pickedMapItems?.markers.first else {
            return
        }

        print(topmostMapMarker.coordinates)
    }
}

protocol MapController {
    func addMarker(_ point: GeoCoordinates, image: UIImage)
    func moveCamera(_ point: GeoCoordinates)
    func darwRoute(start: GeoCoordinates, end: GeoCoordinates,
                   routeColor: UIColor, widthInPixels: CGFloat)
    func drawRoute(_ points: [GeoCoordinates])
}

extension GeoCoordinates: @unchecked @retroactive Sendable {}
