struct ASTPrinter: Visitor {
    func print(expression: Expression) -> String {
        expression.accept(visitor: self)
    }

    func visitBinaryExpression(_ expression: Binary) -> String {
        paranthesize(name: expression.operator.lexeme, expressions: expression.left, expression.right)
    }

    func visitGroupingExpression(_ expression: Grouping) -> String {
        paranthesize(name: "group", expressions: expression.expression)
    }

    func visitLiteralExpression(_ expression: Literal) -> String {
        // TODO: nullチェック
        return expression.literal.text
    }

    func visitUnaryExpression(_ expression: Unary) -> String {
        paranthesize(name: expression.operator.lexeme, expressions: expression.right)
    }

    private func paranthesize(name: String, expressions: Expression...) -> String {
        var result = ""

        result += "("
        result += "\(name)"
        expressions.forEach { e in
            result += " "
            result += e.accept(visitor: self)
        }
        result += ")"

        return result
    }
}
