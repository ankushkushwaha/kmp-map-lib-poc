//
//  HereMapWrapper.swift
//  MyPackage
//
//  Created by Ankush Kushwaha on 20/12/24.
//

import Foundation
import heresdk
import UIKit

public class HereMapWrapper: MapController {
    
    
    nonisolated(unsafe) public static var shared: HereMapWrapper?
    
    public let mapView: MapView
    private let markerActions: MarkerActions
 
    
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

    public func addMarker(at point: Int) {
        
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
    }
}

protocol MapController {
    func addMarker(_ point: GeoCoordinates, image: UIImage) async
    func darwRoute(start: GeoCoordinates, end: GeoCoordinates)
    func darwRoute(points: [Int])
    func darwRoutes(start: GeoCoordinates, end: GeoCoordinates)
    func clearMap()
}

extension GeoCoordinates: @unchecked @retroactive Sendable {}
