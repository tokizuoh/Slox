enum LiteralType {
    case string(text: String)
    case number(value: Double)

    var text: String {
        switch self {
        case .string(let text):
            text
        case .number(let value):
            "\(value)"
        }
    }
}
