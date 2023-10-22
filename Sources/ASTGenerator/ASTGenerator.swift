import Foundation

@main
struct ASTGenerator {
    static func main() {
        let arguments = CommandLine.arguments

        guard arguments.count == 1 else {
            print("Usage: ASTGenerator")
            exit(64)
        }

        let outputDirectory = "./Sources/Lox/generated"
        defineAST(
            outputDirectory: outputDirectory,
            baseName: "Expression",
            types: [
                "Binary: Expression left, TokenType `operator`, Expression right",
                "Grouping: Expression expression",
                "Literal: LiteralType literal",
                "Unary: TokenType `operator`, Expression right"
            ]
        )
    }

    private static func defineAST(outputDirectory: String, baseName: String, types: [String]) {
        defineBase(outputDirectory: outputDirectory, baseName: baseName)

        var contentsString = ""
        types.forEach { t in
            let substrings = t.components(separatedBy: ":")

            let typeName = substrings[0]
            let fields = substrings[1].components(separatedBy: ",").map { s in
                s.trimmingCharacters(in: .whitespaces)
            }
            defineType(
                outputDirectory: outputDirectory,
                baseName: baseName,
                typeName: typeName,
                fields: fields
            )
        }
    }

    private static func defineBase(outputDirectory: String, baseName: String) {
        let path = "\(outputDirectory)/\(baseName).swift"
        let contentsString = "protocol \(baseName) {}"

        let contents = contentsString.data(using: .utf8)
        FileManager.default.createFile(atPath: path, contents: contents)
    }

    private static func defineType(outputDirectory: String, baseName: String, typeName: String, fields: [String]) {
        let path = "\(outputDirectory)/\(typeName).swift"
        var contentsString = ""

        contentsString += "struct \(typeName): \(baseName) {\n"
        fields.forEach { field in
            let components = field.components(separatedBy: " ")
            contentsString += "    let \(components[1]): \(components[0])\n"
        }
        contentsString += "}\n"

        let contents = contentsString.data(using: .utf8)
        FileManager.default.createFile(atPath: path, contents: contents)
    }
}
