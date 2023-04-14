// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RoadKitSwift",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "RoadKitSwift",
            targets: ["RoadKitSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/kaevinio/IONavigation.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/kaevinio/IOSystem.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "RoadKitSwift",
            dependencies: [
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "IONavigation", package: "IONavigation"),
                .product(name: "IOSystem", package: "IOSystem")
            ]),
    ]
)
