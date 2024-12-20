//
//  HereMapWrapper.swift
//  MyPackage
//
//  Created by Ankush Kushwaha on 20/12/24.
//

import Foundation
import heresdk

public struct HereMapWrapper: MapController {
    public init(accessKeyID: String, accessKeySecret: String) {
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
    }

    public func darwRoutes(points: [Int]) {
        print("darwRoutes for points \(points)")
    }
    
    public func addPin(at point: Int) {
        print("addPin for point \(point)")
    }
    
}

protocol MapController {
    func darwRoutes(points: [Int])
    func addPin(at point: Int)
}
