@main
struct ASTGenerator {
    static func main() {
        let arguments = CommandLine.arguments

        guard arguments.count == 2 else {
            print("Usage: ASTGenerator <output directory>")
            exit(64)
        }

        let outputDirectory = arguments[1]
    }
}
