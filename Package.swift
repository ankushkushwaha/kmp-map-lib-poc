// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "here-map-package",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "here-map-package",
            targets: ["here-map-package"])
    ],
    dependencies: [
        .package(url: "https://github.com/googlemaps/ios-maps-sdk", from: "9.3.0")
    ],
    targets: [
        .target(
            name: "here-map-package",
            dependencies: selectedDependencies(),
            path: "Sources"
        ),
        .binaryTarget(
            name: "heresdk",
            path: "Frameworks/heresdk.xcframework"
        ),
        .testTarget(
            name: "here-map-packageTests",
            dependencies: ["here-map-package"]
        ),
    ]
)

func selectedDependencies() -> [Target.Dependency] {
    var dependencies: [Target.Dependency] = []
//#if HERE_MAPS
    dependencies.append(.target(name: "heresdk"))
//#endif
//#if GOOGLE_MAPS
    dependencies.append(.product(name: "GoogleMaps", package: "ios-maps-sdk"))
//#endif
    return dependencies
}

