//
//  MapController.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 17/02/25.
//

import GoogleMaps

public protocol MapController {
    func addMarkers(_ point: [CLLocationCoordinate2D],
                   image: UIImage?,
                   metaDataDict: [String : String]?)
    
//    func addMarkerCluster(_ markers: [MarkerWithData],
//                          clusterImage: UIImage)
    func moveCamera(_ point: CLLocationCoordinate2D)
//    func darwRoute(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D,
//                   routeColor: UIColor, widthInPixels: CGFloat)
    func drawRoute(_ points: [CLLocationCoordinate2D])
}


public struct MarkerWithData {
    public let geoCoordinates: CLLocationCoordinate2D
    public let metaData: [String: String]
    public let image: UIImage

    public init(geoCoordinates: CLLocationCoordinate2D,
                metaData: [String : String],
                image: UIImage) {
        self.geoCoordinates = geoCoordinates
        self.metaData = metaData
        self.image = image
    }
}
