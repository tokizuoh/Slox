// auto-generated

struct Grouping: Expression {
    let expression: Expression

    func accept<V: Visitor>(visitor: V) -> V.E {
        visitor.visitGroupingExpression(self)
    }
}
