// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Networking",
            targets: ["Networking"]),
        .library(
            name: "Authentication",
            targets: ["Authentication"]),
        .library(
            name: "Storage",            
            targets: ["Storage"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Networking"),
        .testTarget(
            name: "NetworkingTests",
            dependencies: [
                "Networking"
            ]
        ),
        .target(
            name: "Authentication",
            dependencies: [
                "Networking"
            ]
        ),
        .testTarget(
            name: "AuthenticationTests",
            dependencies: [
                "Authentication",
                "Networking"
            ]
        ),
        .target(name: "Storage", 
                resources: [
                    .process("Resources")
                ]
               ),
        .testTarget(name: "StorageTests", dependencies: ["Storage"])
    ]
)
