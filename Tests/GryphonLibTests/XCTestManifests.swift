/*
* Copyright 2018 Vinícius Jorge Vendramini
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
	return [
		testCase(GRYExtensionTest.allTests),
		testCase(GRYSwiftTranslatorTest.allTests),
		testCase(GRYKotlinTranslatorTest.allTests),
		testCase(GRYPrintableAsTreeTest.allTests),
		testCase(GRYSExpressionParserTest.allTests),
		testCase(GRYSExpressionEncoderTest.allTests),
		testCase(GRYShellTest.allTests),
		testCase(GRYTranspilationPassTest.allTests),
		testCase(GRYUtilsTest.allTests),
		testCase(IntegrationTest.allTests),
		testCase(AcceptanceTest.allTests),
	]
}
#endif
