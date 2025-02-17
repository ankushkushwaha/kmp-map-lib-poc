//
//  ContentView.swift
//  ExampleGoogleMap
//
//  Created by Ankush Kushwaha on 17/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Add Marker") {
                
            }
            
            GoogleMapsView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
