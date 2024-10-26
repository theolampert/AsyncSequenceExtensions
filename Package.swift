// swift-tools-version: 6.0.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AsyncSequenceExtensions",
    platforms: [.macOS(.v13), .iOS(.v16), .watchOS(.v9), .macCatalyst(.v16), .tvOS(.v16), .visionOS(.v1)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AsyncSequenceExtensions",
            targets: ["AsyncSequenceExtensions"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AsyncSequenceExtensions"),
        .testTarget(
            name: "AsyncSequenceExtensionsTests",
            dependencies: ["AsyncSequenceExtensions"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
