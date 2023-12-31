// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Slox",
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .testTarget(name: "LoxTests", dependencies: ["Lox"], path: "./Tests/LoxTests"),
        .executableTarget(name: "Lox", path: "./Sources/Lox"),
        .executableTarget(name: "ASTGenerator", path: "./Sources/ASTGenerator")
    ]
)
