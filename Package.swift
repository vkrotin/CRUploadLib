// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CRUploadLib",
    products: [
        .library(
            name: "CRUploadLib",
            targets: ["CRUploadLib"]),
    ],
    targets: [
        .binaryTarget(
            name: "CRUploadLib",
            path: "./Sources/CRUploadLib.xcframework")
    ]
)
