// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "flutter_icmp_ping",
    platforms: [
        .iOS("13.0"),
    ],
    products: [
        .library(name: "flutter-icmp-ping", targets: ["flutter_icmp_ping"]),
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "GBPingObjC",
            path: "Sources/GBPingObjC",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
            ]
        ),
        .target(
            name: "flutter_icmp_ping",
            dependencies: [
                "GBPingObjC",
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ],
            path: "Sources/flutter_icmp_ping"
        ),
    ]
)
