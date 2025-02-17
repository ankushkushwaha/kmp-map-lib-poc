//
//  HereMapPocSampleApp.swift
//  HereMapPocSample
//
//  Created by Ankush Kushwaha on 21/12/24.
//

import SwiftUI
import here_map_package
import heresdk

@main
struct HereMapPocSampleApp: App {
    
    init() {
        observeAppLifecycle()
        
        initializeHERESDK()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension HereMapPocSampleApp {
    private func initializeHERESDK() {
        HereMapWrapper.configure(accessKeyID: ACCESS_KEY_ID,
                                 accessKeySecret: ACCESS_KEY_SECRET)
    }
    
    private func disposeHERESDK() {
        // Free HERE SDK resources before the application shuts down.
        // Usually, this should be called only on application termination.
        
        // After this call, the HERE SDK is no longer usable unless it is initialized again.
        SDKNativeEngine.sharedInstance = nil
    }
    
    private func observeAppLifecycle() {
        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification,
                                               object: nil,
                                               queue: nil) { _ in
            // Perform cleanup or final tasks here.
            print("App is about to terminate.")
            disposeHERESDK()
        }
    }
}
