//
//  File.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 14/01/25.
//

import Foundation
import heresdk
import UIKit

class MarkerActions {
 
    private let mapView: MapView
    private var mapMarkers = [MapMarker]()
    private var mapMarkerClusters = [MapMarkerCluster]()

    init(_ mapView: MapView) {
        self.mapView = mapView
    }
    
    @MainActor func addMarker(_ point: GeoCoordinates, image: UIImage) {
        guard let imageData = image.pngData() else {
            print("Error: Image not found.")
            return
        }
        
        let mapImage = MapImage(pixelData: imageData,
                                imageFormat: ImageFormat.png)
        
        let mapMarker = MapMarker(at: point, image: mapImage)
        
        mapView.mapScene.addMapMarker(mapMarker)
        
        mapMarkers.append(mapMarker)
    }
    
    @MainActor public func clearMarkers() {
        // remove marker
        for mapMarker in mapMarkers {
            mapView.mapScene.removeMapMarker(mapMarker)
        }
        mapMarkers.removeAll()
        
        // remove cluster
        for mapMarkerCluster in mapMarkerClusters {
            mapView.mapScene.removeMapMarkerCluster(mapMarkerCluster)
        }
        mapMarkerClusters.removeAll()
    }
    
    @MainActor public func addMapMarkerCluster(_ points: [GeoCoordinates],
                                               clusterImage: UIImage,
                                               markerImage: UIImage? = nil) {
            guard let imageData = clusterImage.pngData() else {
                    print("Error: Image not found.")
                    return
            }

            let clusterMapImage = MapImage(pixelData: imageData,
                                           imageFormat: ImageFormat.png)

            // Defines a text that indicates how many markers are included in the cluster.
            var counterStyle = MapMarkerCluster.CounterStyle()
            counterStyle.textColor = UIColor.black
            counterStyle.fontSize = 40
            counterStyle.maxCountNumber = 9
            counterStyle.aboveMaxText = "+9"

            let mapMarkerCluster = MapMarkerCluster(imageStyle: MapMarkerCluster.ImageStyle(image: clusterMapImage),
                                                    counterStyle: counterStyle)
            mapView.mapScene.addMapMarkerCluster(mapMarkerCluster)
            mapMarkerClusters.append(mapMarkerCluster)

        
        
        for point in points {
            mapMarkerCluster.addMapMarker(marker:
                                            createMapMarker(point, "points", image: markerImage ?? clusterImage))

        }
            var index = 1
            for _ in 1...10 {
                let indexString = String(index)
                mapMarkerCluster.addMapMarker(marker: createRandomMapMarkerInViewport(indexString))
                index = index + 1
            }
        }

    @MainActor func createMapMarker(_ geoCoordinates: GeoCoordinates,
                                    _ metaDataText: String,
                                    image: UIImage) -> MapMarker {
            guard let imageData = image.pngData() else {
                    fatalError("Error: Image not found.")
            }

            let mapImage = MapImage(pixelData: imageData,
                                    imageFormat: ImageFormat.png)
            let mapMarker = MapMarker(at: geoCoordinates, image: mapImage)

            let metadata = Metadata()
            metadata.setString(key: "key_cluster", value: metaDataText)
            mapMarker.metadata = metadata

            return mapMarker
        }
    
    @MainActor func createRandomMapMarkerInViewport(_ metaDataText: String) -> MapMarker {
            let geoCoordinates = createRandomGeoCoordinatesAroundMapCenter()
            guard
                let image = UIImage(systemName: "circle.fill"),
                let imageData = image.pngData() else {
                    fatalError("Error: Image not found.")
            }

            let mapImage = MapImage(pixelData: imageData,
                                    imageFormat: ImageFormat.png)
            let mapMarker = MapMarker(at: geoCoordinates, image: mapImage)

            let metadata = Metadata()
            metadata.setString(key: "key_cluster", value: metaDataText)
            mapMarker.metadata = metadata

            return mapMarker
        }
    
    @MainActor private func createRandomGeoCoordinatesAroundMapCenter() -> GeoCoordinates {
           let scaleFactor = UIScreen.main.scale
           let mapViewWidthInPixels = Double(mapView.bounds.width * scaleFactor)
           let mapViewHeightInPixels = Double(mapView.bounds.height * scaleFactor)
           let centerPoint2D = Point2D(x: mapViewWidthInPixels / 2,
                                       y: mapViewHeightInPixels / 2)
           
           let centerGeoCoordinates = mapView.viewToGeoCoordinates(viewCoordinates: centerPoint2D)
           let lat = centerGeoCoordinates!.latitude
           let lon = centerGeoCoordinates!.longitude
           return GeoCoordinates(latitude: getRandom(min: lat - 0.02,
                                                     max: lat + 0.02),
                                 longitude: getRandom(min: lon - 0.02,
                                                      max: lon + 0.02))
       }

    private func getRandom(min: Double, max: Double) -> Double {
        return Double.random(in: min ... max)
    }
}
