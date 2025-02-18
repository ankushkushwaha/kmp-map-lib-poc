//
//  ExampleGoogleMapApp.swift
//  ExampleGoogleMap
//
//  Created by Ankush Kushwaha on 17/02/25.
//

import SwiftUI
import GoogleMaps
import GoogleMapTarget

@main
struct ExampleGoogleMapApp: App {
    
    init() {
        GoogleMapWrapper.configure("AIzaSyB8o9mrrMBQynPNlT78vaveTAoHfoq1wbA")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

