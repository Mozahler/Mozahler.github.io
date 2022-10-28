// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Mozahler",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "Mozahler.github.io",
            targets: ["Mozahler.github.io"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.8.0"),
        .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin", from: "0.1.0")
        /// I need to write getters and setters for the makeX equivalents
        /// `hero`, `header`, `features`, `callToAction` and `footer`
        /// start with `footer` and see if that helps me figure out how to do the rest
//        .package(path: "../PublishThemes/blau-theme-master")
    ],
    targets: [
        .executableTarget(
            name: "Mozahler.github.io",
            dependencies: ["Publish", "SplashPublishPlugin"
//                           .product(name: "BlauTheme", package: "blau-theme-master")
            ]
        )
    ]
)
