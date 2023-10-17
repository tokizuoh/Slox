final class Scanner {
    private let source: String
    private var tokens: [Token] = []
    private var start = 0
    private var current = 0
    private var line = 1

    private let sourceCount: Int

    private let keywords: [String: TokenType] = [
        "and": .and,
        "class": .class,
        "else": .else,
        "false": .false,
        "for": .for,
        "fun": .fun,
        "if": .if,
        "nil": .nil,
        "or": .or,
        "print": .print,
        "return": .return,
        "super": .super,
        "this": .this,
        "true": .true,
        "var": .var,
        "while": .while
    ]

    init(source: String) {
        self.source = source
        sourceCount = source.count
    }

    var isAtEnd: Bool {
        current >= sourceCount
    }

    func scanTokens() -> [Token] {
        while !isAtEnd {
            start = current
            scanToken()
        }

        tokens.append(
            Token(type: .eof, lexeme: "", literal: nil, line: line)
        )

        return tokens
    }

    private func scanToken() {
        guard let value = advance() else {
            return
        }

        switch value {
        case "(": addToken(type: .leftParenthesis)
        case ")": addToken(type: .rightParenthesis)
        case "{": addToken(type: .leftBrace)
        case "}": addToken(type: .rightBrace)
        case ",": addToken(type: .comma)
        case ".": addToken(type: .dot)
        case "-": addToken(type: .minus)
        case "+": addToken(type: .plus)
        case ";": addToken(type: .semicolon)
        case "*": addToken(type: .star)
        case "!": addToken(type: match(expected: "=") ? .bangEqual : .bang)
        case "=": addToken(type: match(expected: "=") ? .equalEqual : .equal)
        case "<": addToken(type: match(expected: "=") ? .lessEqual : .less)
        case ">": addToken(type: match(expected: "=") ? .greaterEqual : .greater)
        case "/":
            if match(expected: "/") {
                while peek() != "\n" && !isAtEnd {
                    advance()
                }
            } else {
                addToken(type: .slash)
            }
        case " ", "\r", "\t":
            break
        case "\n":
            line += 1
        case "\"":
            string()
        default:
            if Int(value) != nil {
                number()
            } else if isAlphabet(c: Character(value)) {
                identifier()
            } else {
                Lox.error(line: line, message: "Unexpected character.")
                return
            }
        }
    }

    private func isAlphabet(c: Character) -> Bool {
       (c >= "a" && c <= "z") || (c >= "A" && c <= "Z") || c == "_"
    }

    // TODO: current + 1する前に先読みできるかを判断する
    @discardableResult
    private func advance() -> String? {
        let index = source.index(source.startIndex, offsetBy: current)
        current += 1
        return String(source[index])
    }

    private func match(expected: String) -> Bool {
        if isAtEnd {
            return false
        }

        if source.substring(from: current, to: current + 1) != expected {
            return false
        }

        current += 1
        return true
    }

    private func peek() -> String {
        if isAtEnd {
            return "\0"
        }

        return source.substring(from: current, to: current + 1)
    }

    private func peekNext() -> String {
        if current + 1 >= sourceCount {
            return "\0"
        }

        return source.substring(from: current + 1, to: current + 2)
    }
}

// MARK: - Add token
extension Scanner {
    private func addToken(type: TokenType) {
        addToken(type: type, literal: nil)
    }

    private func addToken(type: TokenType, literal: Literal?) {
        let text = source.substring(from: start, to: current)
        tokens.append(
            Token(type: type, lexeme: text, literal: literal, line: line)
        )
    }
}

// MARK: - Scan literal
extension Scanner {
    private func string() {
        while peek() != "\"" && !isAtEnd {
            if peek() == "\n" {
                line += 1
            }
            advance()
        }

        if isAtEnd {
            Lox.error(line: line, message: "Unterminated string.")
            return
        }

        // consume right "\""
        advance()

        // discard left-and-right "\""
        let text = source.substring(from: start + 1, to: current - 1)
        addToken(type: .string, literal: .string(text: text))
    }

    private func number() {
        while Int(peek()) != nil {
            advance()
        }

        if peek() == "." && Int(peekNext()) != nil {
            advance()

            while Int(peek()) != nil {
                advance()
            }
        }

        let value = source.substring(from: start, to: current)
        addToken(type: .number, literal: .number(value: Double(value)!))
    }

    private func identifier() {
        let next = peek()
        while isAlphabet(c: Character(next)) || Int(next) != nil {
            if isAtEnd {
                break
            }

            advance()
        }

        let text = source.substring(from: start, to: current)
        let type = keywords[text]
        if let type {
            addToken(type: type)
        } else {
            addToken(type: .identifier)
        }
    }
}
