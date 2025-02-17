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


class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
        return true
    }
}
