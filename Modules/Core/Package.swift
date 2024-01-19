// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        ),
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
        .library(
            name: "FlickrSDK",
            targets: ["FlickrSDK"]
        ),
        .library(
            name: "Networking",
            targets: ["Networking"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-http-types.git", exact: "1.0.2"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.1.5")
    ],
    targets: [
        .target(name: "Core"),
        
        .target(name: "DesignSystem"),
        
        .target(
            name: "FlickrSDK",
            dependencies: [
                "Core",
                .product(name: "Dependencies", package: "swift-dependencies"),
                "Networking"
            ]
        ),
        .testTarget(
            name: "FlickrSDKTests",
            dependencies: ["FlickrSDK"]
        ),
        
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "HTTPTypesFoundation", package: "swift-http-types")
            ]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),
    ]
)
