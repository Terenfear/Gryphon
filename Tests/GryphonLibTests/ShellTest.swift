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

// gryphon output: Test Files/Bootstrap/ShellTest.kt

#if !GRYPHON
@testable import GryphonLib
import XCTest
#endif

class ShellTest: XCTestCase {
	// gryphon insert: constructor(): super() { }

	// gryphon annotation: override
	public func getClassName() -> String {
		return "ShellTest"
	}

	/// Tests to be run by the translated Kotlin version.
	// gryphon annotation: override
	public func runAllTests() {
		testEcho()
	}

	/// Tests to be run when using Swift on Linux
	// gryphon ignore
	static var allTests = [
		("testEcho", testEcho),
	]

	// MARK: - Tests
	func testEcho() {
		let command: List = ["echo", "foo bar baz"]
		let commandResult = Shell.runShellCommand(command)
		XCTAssertEqual(commandResult.standardOutput, "foo bar baz\n")
		XCTAssertEqual(commandResult.standardError, "")
		XCTAssertEqual(commandResult.status, 0)
	}
}
