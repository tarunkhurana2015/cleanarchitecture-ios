// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "User",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "User",
            targets: ["User"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.2.2"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.10.0"),
        .package(name: "Core", path: "../Core")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "User",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Networking", package: "Core"),
                .product(name: "Authentication", package: "Core")
            ]),
        
        .testTarget(
            name: "UserTests",  
            dependencies: [
                "User",
                .product(name: "Networking", package: "Core"),
                .product(name: "Authentication", package: "Core")
            ]),
        .testTarget(
            name: "DataTests",
            dependencies: [
                "User",
                .product(name: "Networking", package: "Core"),
                .product(name: "Authentication", package: "Core")
            ]),
        .testTarget(
            name: "PresentationTests",
            dependencies: [
                "User"
            ])
    ]
)
