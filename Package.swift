// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TengizReportSP",
    platforms: [
        .macOS(.v10_15), .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TengizReportSP",
            targets: ["Model"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/igor1309/TextReports", .branch("main")),
        .package(url: "https://github.com/igor1309/SwiftToolbox", .branch("main")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Model",
            dependencies: []
        ),
        .testTarget(
            name: "TengizReportSPTests",
            dependencies: ["Model", "TextReports", "SwiftToolbox"]
        ),
    ]
)
