// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "feather-kit",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(name: "FeatherKit", targets: ["FeatherKit"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "FeatherKit",
            dependencies: [
                
            ]
        ),
        .testTarget(
            name: "FeatherKitTests",
            dependencies: [
                .target(name: "FeatherKit"),
            ]
        ),
    ]
)
