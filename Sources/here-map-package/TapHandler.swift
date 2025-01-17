//
//  TapHandler.swift
//  here-map-package
//
//  Created by Ankush Kushwaha on 16/01/25.
//
import heresdk
import UIKit

class TapHandler: @preconcurrency TapDelegate {
    public var markerTapped: ((MapMarker) -> Void)?
    public var clusterTapped: ((MapMarkerCluster.Grouping) -> Void)?

    private let mapView: MapView
    
    @MainActor
    init(_ mapView: MapView) {
        self.mapView = mapView
        mapView.gestures.tapDelegate = self
    }
    
    
    @MainActor public func onTap(origin: Point2D) {
        
        let originInPixels = Point2D(x:origin.x,y:origin.y);
        let sizeInPixels = Size2D(width:1,height:1);
        let rectangle = Rectangle2D(origin: originInPixels, size: sizeInPixels);
        
        // Creates a list of map content type from which the results will be picked.
        // The content type values can be mapContent, mapItems and customLayerData.
        var contentTypesToPickFrom = Array<MapScene.MapPickFilter.ContentType>();
        
        // mapContent is used when picking embedded carto POIs, traffic incidents, vehicle restriction etc.
        // mapItems is used when picking map items such as MapMarker, MapPolyline, MapPolygon etc.
        // Currently we need map markers so adding the mapItems filter.
        contentTypesToPickFrom.append(MapScene.MapPickFilter.ContentType.mapItems);
        let filter = MapScene.MapPickFilter(filter: contentTypesToPickFrom);
        
        mapView.pick(filter: filter, inside: rectangle, completion: onMapItemsPicked)
    }
    
    @MainActor func onMapItemsPicked(mapPickResults: MapPickResult?) {
        let pickedMapItems = mapPickResults?.mapItems;
        // Note that MapMarker items contained in a cluster are not part of pickedMapItems?.markers.
        if let groupingList = pickedMapItems?.clusteredMarkers, groupingList.count > 0 {
            handlePickedMapMarkerClusters(groupingList)
        }
        
        // Note that 3D map markers can't be picked yet. Only marker, polgon and polyline map items are pickable.
        guard let topmostMapMarker = pickedMapItems?.markers.first else {
            return
        }
        
        markerTapped?(topmostMapMarker)
    }
    
    @MainActor private func handlePickedMapMarkerClusters(_ groupingList: [MapMarkerCluster.Grouping]) {
        guard let topmostGrouping = groupingList.first else {
            return
        }
        
        let clusterSize = topmostGrouping.markers.count
        if (clusterSize == 0) {
            // This cluster does not contain any MapMarker items.
            return
        }
        if (clusterSize == 1) {
            
            // individual marker belongs to a cluster
            clusterTapped?(topmostGrouping)
            
        } else {
            var metadata = ""
            for mapMarker in topmostGrouping.markers {
                metadata += getClusterMetadata(mapMarker)
                metadata += " "
            }
            
            clusterTapped?(topmostGrouping)

//            showDialog(title: "Map marker cluster picked",
//                       message: "Number of contained markers in this cluster: \(clusterSize). \(metadataMessage) Total number of markers in this MapMarkerCluster: \(topmostGrouping.parent.markers.count)")
        }
    }
    
    private func getClusterMetadata(_ mapMarker: MapMarker) -> String {
        if let message = mapMarker.metadata?.getString(key: "key_cluster") {
            return message
        }
        return "No metadata."
    }
    
    @MainActor private func showDialog(title: String, message: String) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                // Handle OK button action.
                alert.dismiss(animated: true, completion: nil)
            }))
            
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}
