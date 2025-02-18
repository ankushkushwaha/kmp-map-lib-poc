// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "here-map-package",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        .library(
            name: "GoogleMapsPackage",
            targets: ["GoogleMapTarget"]
        ),
        .library(
            name: "MapboxPackage",
            targets: ["MapboxTarget"]
        ),
        .library(
            name: "HereMapPackage",
            targets: ["HereMapTarget"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/googlemaps/ios-maps-sdk", from: "9.3.0"),
        .package(url: "https://github.com/googlemaps/google-maps-ios-utils", from: "6.1.0"),
        .package(url: "https://github.com/mapbox/mapbox-maps-ios", from: "11.10.0"),
    ],
    targets: [
        // ✅ Google Maps Target
        .target(
            name: "GoogleMapTarget",
            dependencies: [
                .product(name: "GoogleMaps", package: "ios-maps-sdk"),
                .product(name: "GoogleMapsUtils", package: "google-maps-ios-utils")
            ],
            path: "Sources/GoogleMaps"
        ),

        // ✅ Mapbox Target
        .target(
            name: "MapboxTarget",
            dependencies: [
                .product(name: "MapboxMaps", package: "mapbox-maps-ios")
            ],
            path: "Sources/Mapbox"
        ),

        // ✅ HERE Maps Target (Fix)
        .target(
            name: "HereMapTarget",
            dependencies: [
                .target(name: "HereSDKBinary") // Link the binary framework
            ],
            path: "Sources/HereMaps" // Ensure your Here Maps source files exist
        ),

        // ✅ Binary Target for HERE SDK
        .binaryTarget(
            name: "HereSDKBinary",
            path: "Frameworks/heresdk.xcframework"
        )
    ]
)
