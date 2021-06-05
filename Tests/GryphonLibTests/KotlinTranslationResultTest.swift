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

// gryphon output: Test Files/Bootstrap/KotlinTranslationResultTest.kt

#if !GRYPHON
@testable import GryphonLib
import XCTest
#endif

class KotlinTranslationResultTest: XCTestCase {
	// gryphon insert: constructor(): super() { }

	// gryphon annotation: override
	public func getClassName() -> String {
		return "TranslationResultTest"
	}

	/// Tests to be run by the translated Kotlin version.
	// gryphon annotation: override
	public func runAllTests() {
		testShallowTranslation()
		testDeepTranslation()
		testDropLast()
		testIsEmpty()
		testSourceFilePositionPosition()
		testSourceFilePositionCopy()
	}

	/// Tests to be run when using Swift on Linux
	// gryphon ignore
	static var allTests = [
		("testShallowTranslation", testShallowTranslation),
		("testDeepTranslation", testDeepTranslation),
		("testDropLast", testDropLast),
		("testIsEmpty", testIsEmpty),
		("testSourceFilePositionPosition", testSourceFilePositionPosition),
		("testSourceFilePositionCopy", testSourceFilePositionCopy),
	]

	// MARK: - Tests
	func testShallowTranslation() {
		let translation = KotlinTranslation(range: SourceFileRange(
			lineStart: 1, lineEnd: 1, columnStart: 1, columnEnd: 5))
		translation.append("fun ")
		translation.append("foo(")
		translation.append("bla: Int")
		translation.append(")")
		translation.append(": Int")
		translation.append(" {\n")
		translation.append("\treturn bla\n")
		translation.append("}\n")
		let result = translation.resolveTranslation()

		XCTAssertEqual(result.translation, "fun foo(bla: Int): Int {\n\treturn bla\n}\n")
		XCTAssertEqual(result.errorMap, "1:1:4:1:1:1:1:5")
	}

	func testDeepTranslation() {
		let translation = getDeepTranslation()
		translation.append("}\n")

		let result = translation.resolveTranslation()

		XCTAssertEqual(result.translation, """
			fun foo(bla: Int): Int {
				return bla
				return bla + 1
			}

			""")
		XCTAssertEqual(result.errorMap, """
			2:1:3:1:2:1:2:5
			3:9:4:1:3:3:3:5
			3:1:4:1:3:1:3:2
			1:1:5:1:1:1:5:1
			""")
	}

	func testDropLast() {
		let translation = getDeepTranslation()

		//
		translation.dropLast(" + 1\n")
		translation.append("\n}\n")

		let result = translation.resolveTranslation()
		XCTAssertEqual(result.translation, """
			fun foo(bla: Int): Int {
				return bla
				return bla
			}

			""")
	}

	func testIsEmpty() {
		let translation = KotlinTranslation(range: SourceFileRange(
			lineStart: 1, lineEnd: 5, columnStart: 1, columnEnd: 1))
		translation.append("")

		let translation2 = KotlinTranslation(range: SourceFileRange(
			lineStart: 2, lineEnd: 2, columnStart: 1, columnEnd: 5))
		translation2.append("")
		translation2.append("")

		translation.append(translation2)

		let translation3 = KotlinTranslation(range: SourceFileRange(
			lineStart: 3, lineEnd: 3, columnStart: 1, columnEnd: 2))
		translation3.append("")

		let translation4 = KotlinTranslation(range: SourceFileRange(
			lineStart: 3, lineEnd: 3, columnStart: 3, columnEnd: 5))
		translation4.append("")

		translation3.append(translation4)
		translation.append(translation3)

		//
		let emptyTranslation = KotlinTranslation(range: SourceFileRange(
			lineStart: 1, lineEnd: 5, columnStart: 1, columnEnd: 1))

		//
		XCTAssert(translation.isEmpty)
		XCTAssert(emptyTranslation.isEmpty)
		XCTAssertFalse(getDeepTranslation().isEmpty)
	}

	func testSourceFilePositionPosition() {
		let position = SourceFilePosition()
		XCTAssertEqual(position.lineNumber, 1)
		XCTAssertEqual(position.columnNumber, 1)

		position.updateWithString("bla")
		XCTAssertEqual(position.lineNumber, 1)
		XCTAssertEqual(position.columnNumber, 4)

		position.updateWithString("bla")
		XCTAssertEqual(position.lineNumber, 1)
		XCTAssertEqual(position.columnNumber, 7)

		position.updateWithString("\n")
		XCTAssertEqual(position.lineNumber, 2)
		XCTAssertEqual(position.columnNumber, 1)

		position.updateWithString("blabla")
		XCTAssertEqual(position.lineNumber, 2)
		XCTAssertEqual(position.columnNumber, 7)

		position.updateWithString("blabla\n")
		XCTAssertEqual(position.lineNumber, 3)
		XCTAssertEqual(position.columnNumber, 1)

		position.updateWithString("blabla\nblabla")
		XCTAssertEqual(position.lineNumber, 4)
		XCTAssertEqual(position.columnNumber, 7)
	}

	func testSourceFilePositionCopy() {
		let position = SourceFilePosition()
		let position2 = position.copy()

		XCTAssertEqual(position.lineNumber, position2.lineNumber)
		XCTAssertEqual(position.columnNumber, position2.columnNumber)

		position.updateWithString("blabla\nblabla")
		let position3 = position.copy()

		XCTAssertNotEqual(position.lineNumber, position2.lineNumber)
		XCTAssertNotEqual(position.columnNumber, position2.columnNumber)
		XCTAssertEqual(position.lineNumber, position3.lineNumber)
		XCTAssertEqual(position.columnNumber, position3.columnNumber)

		position.updateWithString("blabla\nblablabla")

		XCTAssertNotEqual(position.lineNumber, position2.lineNumber)
		XCTAssertNotEqual(position.columnNumber, position2.columnNumber)
		XCTAssertNotEqual(position.lineNumber, position3.lineNumber)
		XCTAssertNotEqual(position.columnNumber, position3.columnNumber)
	}

	// MARK: Auxiliary methods
	func getDeepTranslation() -> KotlinTranslation {
		let translation = KotlinTranslation(range: SourceFileRange(
			lineStart: 1, lineEnd: 5, columnStart: 1, columnEnd: 1))
		translation.append("fun foo(bla: Int): Int {\n")

		let translation2 = KotlinTranslation(range: SourceFileRange(
			lineStart: 2, lineEnd: 2, columnStart: 1, columnEnd: 5))
		translation2.append("\treturn ")
		translation2.append("bla\n")

		translation.append(translation2)

		let translation3 = KotlinTranslation(range: SourceFileRange(
			lineStart: 3, lineEnd: 3, columnStart: 1, columnEnd: 2))
		translation3.append("\treturn ")

		let translation4 = KotlinTranslation(range: SourceFileRange(
			lineStart: 3, lineEnd: 3, columnStart: 3, columnEnd: 5))
		translation4.append("bla + 1\n")

		translation3.append(translation4)
		translation.append(translation3)

		return translation
	}
}
