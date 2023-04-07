// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Endpoint",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Endpoint",
            targets: ["Endpoint"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Endpoint",
            dependencies: []
        ),        
    ],
    swiftLanguageVersions: [.v5]
)
