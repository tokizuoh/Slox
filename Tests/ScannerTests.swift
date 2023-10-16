import XCTest
@testable import Slox

final class ScannerTests: XCTestCase {
    struct TestCase {
        let source: String
        let tokenType: TokenType

        init(_ source: String, _ tokenType: TokenType) {
            self.source = source
            self.tokenType = tokenType
        }
    }

    func testScanSymbols() throws {
        let testCases: [TestCase] = [
            .init("(", .leftParenthesis),
            .init(")", .rightParenthesis),
            .init("{", .leftBrace),
            .init("}", .rightBrace),
            .init(",", .comma),
            .init(".", .dot),
            .init("-", .minus),
            .init("+", .plus),
            .init(";", .semicolon),
            .init("*", .star),
            .init("!", .bang),
            .init("=", .equal),
            .init("<", .less),
            .init(">", .greater),
            .init("/", .slash),
            .init("!=", .bangEqual),
            .init("==", .equalEqual),
            .init("<=", .lessEqual),
            .init(">=", .greaterEqual)
        ]

        for testCase in testCases {
            let scanner = Scanner(source: testCase.source)
            let tokens = scanner.scanTokens()
            XCTAssertEqual(tokens.count, 2)
            XCTAssertEqual(tokens[0].type, testCase.tokenType)
            XCTAssertEqual(tokens[0].lexeme, testCase.source)
            XCTAssertNil(tokens[0].literal)

            XCTAssertEqual(tokens[1].type, .eof)
        }
    }

    func testScanComment() throws {
        let scanner = Scanner(source: "//")
        let tokens = scanner.scanTokens()
        XCTAssertEqual(tokens.count, 1)
        XCTAssertEqual(tokens[0].type, .eof)
    }
}
