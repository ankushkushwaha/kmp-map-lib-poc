//
//  ContentView.swift
//  HereMapPocSample
//
//  Created by Ankush Kushwaha on 21/12/24.
//

import SwiftUI
import here_map_package

struct ContentView: View {
    
    let hereMap = HereMapWrapper(accessKeyID: ACCESS_KEY_ID, accessKeySecret: ACCESS_KEY_SECRET)
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Show map") {
                hereMap.addPin(at: 2)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


 let ACCESS_KEY_ID = "nzK5NTVRrBB7zoixWk5puw"
 let ACCESS_KEY_SECRET = "VZ5aGmGSZ9zFQR87D8eH6tEFWv2BhoKp4D-YX0C4kEEykIEUQvh_GnrHoW5X_GWzl3cN118kI_3YX0Dlk_4TVQ"
