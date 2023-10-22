// auto-generated

struct Literal: Expression {
    let literal: LiteralType

    func accept<V: Visitor>(visitor: V) -> V.E {
        visitor.visitLiteralExpression(self)
    }
}
