//
//  File.swift
//  lib-here-map-package
//
//  Created by Ankush Kushwaha on 17/02/25.
//

import Foundation
import GoogleMaps

public class GoogleMapWrapper: MapController {

    
    
    public let mapView: GMSMapView

    public static var shared: GoogleMapWrapper?
    private let cameraAction: CameraAction
    private let markerAction: MarkerActions

    public static func configure(_ accessKeyID: String) {
        guard shared == nil else {
            fatalError("HereMapWrapper is already configured.")
        }
        shared = GoogleMapWrapper(accessKeyID)
    }
    
    init(_ accessKey: String) {
        
        GMSServices.provideAPIKey(accessKey)
        self.mapView = GMSMapView()
        self.cameraAction = CameraAction(mapView)
        self.markerAction = MarkerActions(mapView)
    }
    
        
    
    public func addMarkers(_ points: [CLLocationCoordinate2D], image: UIImage?, metaDataDict: [String : String]?) {
        markerAction.addMarkers(points)
    }
    
    func addMarkerCluster(_ markers: [MarkerWithData], clusterImage: UIImage) {
        
    }
    
    @MainActor public func moveCamera(_ point: CLLocationCoordinate2D) {
        cameraAction.moveCamera(to: point)
    }
    
    func darwRoute(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, routeColor: UIColor, widthInPixels: CGFloat) {
        
    }
    
    func drawRoute(_ points: [CLLocationCoordinate2D]) {
        
    }
    
    
}



