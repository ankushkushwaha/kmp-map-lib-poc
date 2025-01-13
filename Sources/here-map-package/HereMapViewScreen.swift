//
//  MapView.swift
//  iosApp
//
//  Created by Ankush Kushwaha on 01/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import heresdk

struct HereMapViewScreen: View {
    
    @State private var mapView = MapView()
    @State private var routingExample: RoutingExample?

    @State var enableAddRouteButton: Bool = true
    var body: some View {
        ZStack(alignment: .top) {
            MapViewUIRepresentable(mapView: $mapView)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button("Add route") {
                        if enableAddRouteButton {
                            enableAddRouteButton = false
                            routingExample?.addRoute()
                        }
                    }
                    .padding()
                    .background(Color(red: 0, green: 182/255, blue: 178/255))
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .opacity(enableAddRouteButton ? 1.0 : 0.5)

                }
            }
            .padding(50)
        }
        .onAppear {
            // ContentView appeared, now we init the example.
            routingExample = RoutingExample(mapView, animationCompletion: {
                enableAddRouteButton = true
            })
        }
    }
    
}
