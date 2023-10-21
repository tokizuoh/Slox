final class Token {
    let type: TokenType
    let lexeme: String
    let literal: Literal?
    let line: Int

    init(
        type: TokenType,
        lexeme: String,
        literal: Literal?,
        line: Int
    ) {
        self.type = type
        self.lexeme = lexeme
        self.literal = literal
        self.line = line
    }

    func toString() -> String {
        let value = switch literal {
        case .string(let value):
            value
        case .number(let value):
            "\(value)"
        default:
            ""
        }

        return "\(type) \(lexeme) \(value)"
    }
}
