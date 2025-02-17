//
//  MapController.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 17/02/25.
//

import heresdk
import UIKit

public protocol MapController {
    func addMarker(_ point: GeoCoordinates,
                   image: UIImage,
                   metaDataDict: [String : String]?)
    
    func addMarkerCluster(_ markers: [MarkerWithData],
                          clusterImage: UIImage)
    func moveCamera(_ point: GeoCoordinates)
    func darwRoute(start: GeoCoordinates, end: GeoCoordinates,
                   routeColor: UIColor, widthInPixels: CGFloat)
    func drawRoute(_ points: [GeoCoordinates])
}
