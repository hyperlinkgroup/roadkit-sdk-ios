// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Roadkit",
    platforms: [
        .iOS(.v14),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "Roadkit",
            targets: ["Roadkit"]),
    ],
    dependencies: [
         .package(url: "https://github.com/kaevinio/IOSystem.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "Roadkit",
            dependencies: [
                .product(name: "IOSystem", package: "IOSystem")
            ]),
    ]
)
