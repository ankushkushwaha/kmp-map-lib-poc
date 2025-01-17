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
 
    
    public var markerTapped: ((MapMarker) -> Void)? {
        didSet {
            tapHandler.markerTapped = markerTapped
        }
    }
        
    nonisolated(unsafe) public static var shared: HereMapWrapper?
    
    public let mapView: MapView
    private let markerActions: MarkerActions
    private let cameraAction: CameraAction
    private let routingAction: RoutingActions
    private let tapHandler: TapHandler

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
    
    @MainActor public func addMarker(_ point: GeoCoordinates,
                                     image: UIImage,
                                     metaDataDict: [String : String]? = nil) {
        markerActions.addMarker(point, image: image,
                                metaDataDict: metaDataDict)
    }
    
    @MainActor public func addMarkerCluster(_ points: [GeoCoordinates],
                                            clusterImage: UIImage,
                                            markerImage: UIImage? = nil) {
        markerActions.addMapMarkerCluster(points,
                                          clusterImage: clusterImage,
                                          markerImage: markerImage ?? clusterImage)
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
        self.tapHandler = TapHandler(mapView)
        
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
    func addMarker(_ point: GeoCoordinates,
              image: UIImage,
              metaDataDict: [String : String]?)
    
    func addMarkerCluster(_ points: [GeoCoordinates],
                                            clusterImage: UIImage,
                                            markerImage: UIImage?)
    func moveCamera(_ point: GeoCoordinates)
    func darwRoute(start: GeoCoordinates, end: GeoCoordinates,
                   routeColor: UIColor, widthInPixels: CGFloat)
    func drawRoute(_ points: [GeoCoordinates])
}

extension GeoCoordinates: @unchecked @retroactive Sendable {}
