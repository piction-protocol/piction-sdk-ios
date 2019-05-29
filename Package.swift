// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PictionSDK",
    platforms: [.iOS(.v8)],
    products: [
        .library(
            name: "PictionSDK",
            targets: ["PictionSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sunshinejr/Moya-ModelMapper.git", .upToNextMajor(from: "9.0.0")),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", .upToNextMajor(from: "3.2.0"))
    ],
    targets: [
        .target(
            name: "PictionSDK",
            dependencies: ["Moya-ModelMapper", "KeychainAccess"],
            path: "Sources"),
        .testTarget(
            name: "PictionSDKTests",
            dependencies: ["PictionSDK"]),
    ]
)
