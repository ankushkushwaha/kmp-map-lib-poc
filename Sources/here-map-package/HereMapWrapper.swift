//
//  HereMapWrapper.swift
//  MyPackage
//
//  Created by Ankush Kushwaha on 20/12/24.
//

import Foundation

public struct HereMapWrapper: MapController {
    public init() {}

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
