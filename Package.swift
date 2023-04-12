// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RoadKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "RoadKit",
            targets: ["RoadKit"]),
    ],
    dependencies: [
         .package(url: "https://github.com/kaevinio/IOSystem.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "RoadKit",
            dependencies: [
                .product(name: "IOSystem", package: "IOSystem")
            ]),
    ]
)
