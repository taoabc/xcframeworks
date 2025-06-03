// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "XCFrameworks",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "MMKV", targets: ["MMKV"])
    ],
    targets: [
        .target(name: "MMKV", path: "MMKV")
    ]
)