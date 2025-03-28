// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "LCLanguage",
    defaultLocalization: "en", // 指定默认语言为英文
    platforms: [
        .macOS(.v10_15) // 指定支持的 macOS 版本
    ],
    products: [
        .library(
            name: "LCLanguage",
            targets: ["LCLanguage"]),
    ],
    targets: [
        .target(
            name: "LCLanguage",
            resources: [
                .process("Sources/LCLanguage/Resources/de.lproj/LCLanguage.strings"),
                .process("Sources/LCLanguage/Resources/en.lproj/LCLanguage.strings"),
                .process("Sources/LCLanguage/Resources/es.lproj/LCLanguage.strings"),
                .process("Sources/LCLanguage/Resources/fr.lproj/LCLanguage.strings"),
                .process("Sources/LCLanguage/Resources/it.lproj/LCLanguage.strings"),
                .process("Sources/LCLanguage/Resources/ja.lproj/LCLanguage.strings"),
                .process("Sources/LCLanguage/Resources/ko.lproj/LCLanguage.strings"),
                .process("Sources/LCLanguage/Resources/pt-PT.lproj/LCLanguage.strings"),
                .process("Sources/LCLanguage/Resources/ru.lproj/LCLanguage.strings"),
                .process("Sources/LCLanguage/Resources/zh-HK.lproj/LCLanguage.strings"),
                .process("Sources/LCLanguage/Resources/zh-Hans.lproj/LCLanguage.strings")
            ]),
        .testTarget(
            name: "LCLanguageTests",
            dependencies: ["LCLanguage"]),
    ]
)
