// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "MMKV",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "MMKV",
            targets: ["MMKVWrapper"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "MMKV",
            url: "https://github.com/user-attachments/files/20517305/MMKV-1.3.14.xcframework.zip",
            checksum: "0a564ee81751effe71b7533d77348b8d015893ecf88ad76c9cee49ae3712c16d"
        ),
        .binaryTarget(
            name: "MMKVCore",
            url: "https://github.com/user-attachments/files/20517306/MMKVCore-1.3.14.xcframework.zip",
            checksum: "a7c714aaccd9e4fb51b43f0da5d0f67808e8d3b0ddd804687c272eb0e34bc48c"
        ),
        .target(name: "MMKVWrapper", dependencies: ["MMKV", "MMKVCore"])
    ]
)
