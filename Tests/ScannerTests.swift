import XCTest
@testable import Lox

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

    func testScanIdentifier() throws {
        XCTContext.runActivity(named: "scan identifier") { _ in
            let scanner = Scanner(source: "hoge")
            let tokens = scanner.scanTokens()
            XCTAssertEqual(tokens.count, 2)
            XCTAssertEqual(tokens[0].type, .identifier)
            XCTAssertEqual(tokens[0].lexeme, "hoge")
            XCTAssertNil(tokens[0].literal)

            XCTAssertEqual(tokens[1].type, .eof)
        }

        XCTContext.runActivity(named: "scan identifier similar keywords") { _ in
            let scanner = Scanner(source: "andd")
            let tokens = scanner.scanTokens()
            XCTAssertEqual(tokens.count, 2)
            XCTAssertEqual(tokens[0].type, .identifier)
            XCTAssertEqual(tokens[0].lexeme, "andd")
            XCTAssertNil(tokens[0].literal)

            XCTAssertEqual(tokens[1].type, .eof)
        }

        XCTContext.runActivity(named: "scan identifier similar keywords") { _ in
            let scanner = Scanner(source: "aand")
            let tokens = scanner.scanTokens()
            XCTAssertEqual(tokens.count, 2)
            XCTAssertEqual(tokens[0].type, .identifier)
            XCTAssertEqual(tokens[0].lexeme, "aand")
            XCTAssertNil(tokens[0].literal)

            XCTAssertEqual(tokens[1].type, .eof)
        }
    }

    func testScanKeyword() throws {
        let testCases: [TestCase] = [
            .init("and", .and),
            .init("class", .class),
            .init("else", .else),
            .init("false", .false),
            .init("for", .for),
            .init("if", .if),
            .init("nil", .nil),
            .init("or", .or),
            .init("print", .print),
            .init("return", .return),
            .init("super", .super),
            .init("this", .this),
            .init("true", .true),
            .init("var", .var),
            .init("while", .while)
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
}
