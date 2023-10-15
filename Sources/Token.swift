final class Token {
    let type: TokenType
    let lexeme: String
    let literal: String  // TODO: JavaではObject型
    let line: Int

    init(
        type: TokenType,
        lexeme: String,
        literal: String,
        line: Int
    ) {
        self.type = type
        self.lexeme = lexeme
        self.literal = literal
        self.line = line
    }

    func toString() -> String {
        return "\(type) \(lexeme) \(literal)"
    }
}
