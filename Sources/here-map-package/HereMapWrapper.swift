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

    
    @MainActor public static func configure(accessKeyID: String, accessKeySecret: String) {
        guard shared == nil else {
            fatalError("HereMapWrapper is already configured.")
        }
        shared = HereMapWrapper(accessKeyID: accessKeyID, accessKeySecret: accessKeySecret)
    }
    
    public func clearMap() {
        
    }
    
    @MainActor public func addMarker(_ point: GeoCoordinates, image: UIImage) {
        markerActions.addMarker(point, image: image)
    }
    
    @MainActor public func moveCamera(_ point: GeoCoordinates) {
        cameraAction.moveCamera(point)
    }

    
    public func darwRoute(start: heresdk.GeoCoordinates, end: heresdk.GeoCoordinates) {
        
    }
    
    public func darwRoute(points: [Int]) {
        
    }
    
    public func darwRoutes(start: heresdk.GeoCoordinates, end: heresdk.GeoCoordinates) {
        
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
        
        // Load the map scene using a map scheme to render the map with.
        mapView.mapScene.loadScene(mapScheme: MapScheme.normalDay, completion: onLoadScene)
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

protocol MapController {
    func addMarker(_ point: GeoCoordinates, image: UIImage)
    func moveCamera(_ point: GeoCoordinates)
    func darwRoute(start: GeoCoordinates, end: GeoCoordinates)
    func darwRoute(points: [Int])
    func darwRoutes(start: GeoCoordinates, end: GeoCoordinates)
}

extension GeoCoordinates: @unchecked @retroactive Sendable {}
