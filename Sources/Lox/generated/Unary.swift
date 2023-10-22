// this file generated 

struct Unary: Expression {
    let `operator`: Token
    let right: Expression

    func accept<V: Visitor>(visitor: V) -> V.E {
        visitor.visitUnaryExpression(self)
    }
}
