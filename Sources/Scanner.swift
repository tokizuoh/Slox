final class Scanner {
    private let source: String
    private var tokens: [Token] = []
    private var start = 0
    private var current = 0
    private var line = 1

    private let sourceCount: Int

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
            scanTokens()
        }

        tokens.append(
            Token(type: .eof, lexeme: "", literal: "", line: line)
        )

        return tokens
    }

    private func scanToken() {
        guard let value = advance() else {
            Lox.error(line: line, message: "TODO")
            return
        }

        switch value {
        case "(": addToken(type: .leftParenthesis)
        case ")": addToken(type: .RightParenthesis)
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
        default:
            Lox.error(line: line, message: "Unexpected character.")
            return
        }

    }

    @discardableResult
    private func advance() -> String? {
        if current + 1 < sourceCount {
            current += 1
            let index = source.index(source.startIndex, offsetBy: current)
            return String(source[index])
        } else {
            return nil
        }
    }

    private func addToken(type: TokenType) {
        addToken(type: type, literal: "")
    }

    private func addToken(type: TokenType, literal: String) {
        let startIndex = source.index(source.startIndex, offsetBy: start)
        let currentIndex = source.index(source.startIndex, offsetBy: current)

        let text = String(source[startIndex...currentIndex])
        tokens.append(
            Token(type: type, lexeme: text, literal: literal, line: line)
        )
    }

    private func match(expected: String) -> Bool {
        if isAtEnd {
            return false
        }

        let currentIndex = source.index(source.startIndex, offsetBy: current)
        if String(source[currentIndex...currentIndex]) != expected {
            return false
        }

        current += 1
        return true
    }

    private func peek() -> String {
        if isAtEnd {
            return "\0"
        }

        let currentIndex = source.index(source.startIndex, offsetBy: current)
        return String(source[currentIndex...currentIndex])
    }
}
