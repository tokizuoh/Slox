import XCTest
@testable import Slox

final class ScannerTests: XCTestCase {
    func testScanner() throws {
        let scanner = Scanner(source: "+")
        let tokens = scanner.scanTokens()
        XCTAssertEqual(tokens.count, 2)
        XCTAssertEqual(tokens[0].type, .plus)
        XCTAssertEqual(tokens[0].lexeme, "+")
        XCTAssertNil(tokens[0].literal)

        XCTAssertEqual(tokens[1].type, .eof)
    }
}
