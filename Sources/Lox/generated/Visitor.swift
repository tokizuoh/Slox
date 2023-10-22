// auto-generated

protocol Visitor {
    associatedtype E
    func visitBinaryExpression(_ expression: Binary) -> E
    func visitGroupingExpression(_ expression: Grouping) -> E
    func visitLiteralExpression(_ expression: Literal) -> E
    func visitUnaryExpression(_ expression: Unary) -> E
}
