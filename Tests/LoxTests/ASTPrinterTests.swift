//
//  ASTPrinterTests.swift
//  
//
//  Created by tokizo on 2023/10/22.
//

import XCTest
@testable import Lox

final class ASTPrinterTests: XCTestCase {
    func testPrint() {
        let actual = ASTPrinter().print(
            expression: Binary(
                left: Unary(
                    operator: Token(
                        type: .minus,
                        lexeme: "-",
                        literal: nil,
                        line: 1
                    ),
                    right: Literal(
                        literal: .number(value: 123)
                    )
                ),
                operator: Token(
                    type: .star,
                    lexeme: "*",
                    literal: nil,
                    line: 1
                ),
                right: Grouping(
                    expression: Literal(
                        literal: .number(value: 45.67)
                    )
                )
            )
        )
        let expected = "(* (- 123.0) (group 45.67))"
        XCTAssertEqual(actual, expected)
    }

}
