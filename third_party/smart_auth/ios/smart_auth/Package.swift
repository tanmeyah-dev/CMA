// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "smart_auth",
    platforms: [
        .iOS("13.0"),
    ],
    products: [
        .library(name: "smart-auth", targets: ["smart_auth"]),
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "smart_auth",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            path: "Sources/smart_auth"
        ),
    ]
)
