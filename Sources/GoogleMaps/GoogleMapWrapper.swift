//
//  File.swift
//  lib-here-map-package
//
//  Created by Ankush Kushwaha on 17/02/25.
//

import Foundation
import GoogleMaps

public class GoogleMapWrapper: MapController {

    public var mapView: GMSMapView?
    public var mapViewRepresentable: MapRepresentable

    public static var shared: GoogleMapWrapper?
    private var cameraAction: CameraAction?
    private var markerAction: MarkerActions?
    private var routingAction: RoutingActions?

    public static func configure(_ accessKeyID: String) {
        guard shared == nil else {
            fatalError("HereMapWrapper is already configured.")
        }
        shared = GoogleMapWrapper(accessKeyID)
    }
    
    init(_ accessKey: String) {
        
        GMSServices.provideAPIKey(accessKey)

        self.mapViewRepresentable = MapRepresentable()
        
        mapViewRepresentable.mapCreated = { [weak self] mapView in
            self?.mapView = mapView
            
            self?.cameraAction = CameraAction(mapView)
            self?.markerAction = MarkerActions(mapView)
            self?.routingAction = RoutingActions(mapView)
        }
    }
        
    public func addMarkers(_ points: [CLLocationCoordinate2D], image: UIImage?, metaDataDict: [String : String]?) {
        markerAction?.addMarkers(points)
    }
    
    func addMarkerCluster(_ markers: [MarkerWithData], clusterImage: UIImage) {
        
    }
    
    @MainActor public func moveCamera(_ point: CLLocationCoordinate2D) {
        cameraAction?.moveCamera(to: point)
    }
    
    func darwRoute(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, routeColor: UIColor, widthInPixels: CGFloat) {
        
    }
    
    public func drawRoute(_ points: [CLLocationCoordinate2D]) {
        routingAction?.addRoute(points: points)
    }
    
    
}



