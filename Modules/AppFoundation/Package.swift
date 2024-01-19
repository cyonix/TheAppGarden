// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AppFoundation",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AppFoundation",
            targets: ["AppFoundation"]
        ),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.1.5"),
        .package(url: "https://github.com/kean/Nuke", exact: "12.3.0")
    ],
    targets: [
        .target(
            name: "AppFoundation",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "FlickrSDK", package: "Core"),
                .product(name: "DesignSystem", package: "Core"),
                .product(name: "NukeUI", package: "Nuke")
            ]
        ),
        .testTarget(
            name: "AppFoundationTests",
            dependencies: ["AppFoundation"]
        ),
    ]
)
