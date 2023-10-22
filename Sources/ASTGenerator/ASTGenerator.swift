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
        defineVisitor(outputDirectory: outputDirectory, baseName: baseName, types: types)

        types.forEach { t in
            let components = t.components(separatedBy: ":")

            let typeName = components[0]
            let fields = components[1].components(separatedBy: ",").map { s in
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
        let contentsString = "protocol \(baseName) {}\n"

        createFile(atPath: path, contentsString: contentsString)
    }

    private static func defineVisitor(outputDirectory: String, baseName: String, types: [String]) {
        let path = "\(outputDirectory)/Visitor.swift"
        var contentsString = ""

        contentsString +=  "protocol Visitor {\n"
        types.forEach { t in
            let components = t.components(separatedBy: ":")
            let typeName = components[0]
            contentsString += "    func visit\(typeName)\(baseName)(\(baseName.lowercased()): \(typeName)) -> \(baseName)\n"
        }
        contentsString += "}\n"

        createFile(atPath: path, contentsString: contentsString)
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

        createFile(atPath: path, contentsString: contentsString)
    }

    private static func createFile(atPath path: String, contentsString: String) {
        let header = "// this file generated \n\n"
        let contents = (header + contentsString).data(using: .utf8)
        FileManager.default.createFile(atPath: path, contents: contents)
    }
}
