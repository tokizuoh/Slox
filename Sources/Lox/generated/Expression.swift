// this file generated 

protocol Expression {
    func accept<V: Visitor>(visitor: V) -> V.E
}
