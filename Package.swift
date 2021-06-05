// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

//
// Copyright 2018 Vinicius Jorge Vendramini
//
// Gryphon - Copyright (2018) Vinícius Jorge Vendramini (“Licensor”)
// Licensed under the Hippocratic License, Version 2.1 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// https://firstdonoharm.dev/version/2/1/license
//
// To the full extent allowed by law, this software comes "AS IS,"
// WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED, and licensor and any other
// contributor shall not be liable to anyone for any damages or other
// liability arising from, out of, or in connection with the sotfware
// or this license, under any kind of legal claim.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import PackageDescription

let package = Package(
	name: "Gryphon",
	platforms: [
		.macOS(.v10_13)
		/* Linux */
	],
	products: [
		.executable(name: "gryphon", targets: ["Gryphon"])
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "GryphonLib",
			dependencies: []),
		.target(
			name: "Gryphon",
			dependencies: ["GryphonLib"]),
		.testTarget(
			name: "GryphonLibTests",
			dependencies: ["GryphonLib"])
	],
	swiftLanguageVersions: [.v5]
)
