// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ISO8601DurationFormatter",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "ISO8601DurationFormatter",
            targets: ["ISO8601DurationFormatter"]),
    ],
    targets: [
        .target(
            name: "ISO8601DurationFormatter",
            path: "Sources"
        ),
        .testTarget(
            name: "ISO8601DurationFormatterTests",
            dependencies: ["ISO8601DurationFormatter"],
            path: "Tests"
        ),
    ]
)
