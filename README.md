# Feather Kit

The `FeatherKit` library provides generic solutions for both server and client interfaces.

## Current components:

- A generic solution for listing objects including filter, sort and page info.

## Getting started

⚠️ This repository is a work in progress, things can break until it reaches v1.0.0. 

Use at your own risk.

### Adding the dependency

To add a dependency on the package, declare it in your `Package.swift`:

```swift
.package(url: "https://github.com/feather-framework/feather-kit", .upToNextMinor(from: "0.1.0")),
```

and to your application target, add `FeatherKit` to your dependencies:

```swift
.product(name: "FeatherKit", package: "feather-kit")
```

Example `Package.swift` file with `FeatherKit` as a dependency:

```swift
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "my-application",
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-kit", .upToNextMinor(from: "0.1.0")),
    ],
    targets: [
        .target(name: "MyApplication", dependencies: [
            .product(name: "FeatherKit", package: "feather-kit")
        ]),
        .testTarget(name: "MyApplicationTests", dependencies: [
            .target(name: "MyApplication"),
        ]),
    ]
)
```

