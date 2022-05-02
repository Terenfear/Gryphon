//
// Copyright 2018 Vinicius Jorge Vendramini
//
// Licensed under the Hippocratic License, Version 2.1;
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

#if !GRYPHON
@testable import GryphonLib
import XCTest
#endif

import Foundation

extension TestUtilities {
	static func changeCurrentDirectoryPath(_ newPath: String) {
		let success = FileManager.default.changeCurrentDirectoryPath(newPath)
		assert(success)
	}

	static let libraryASTDumpFilePath = "ASTDumps-Swift-5.5/gryphon/GryphonTemplatesLibrary.swiftASTDump"
}
