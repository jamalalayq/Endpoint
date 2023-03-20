// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "HTTPSessionType",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "HTTPSessionType",
            targets: ["HTTPSessionType"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "HTTPSessionType",
            dependencies: []
        ),
        .testTarget(
            name: "HTTPSessionTypeTests",
            dependencies: ["HTTPSessionType"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
