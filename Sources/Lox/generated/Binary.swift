// this file generated 

struct Binary: Expression {
    let left: Expression
    let `operator`: Token
    let right: Expression

    func accept<V: Visitor>(visitor: V) -> V.E {
        visitor.visitBinaryExpression(self)
    }
}
