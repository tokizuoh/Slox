@main
struct ASTGenerator {
    static func main() {
        let arguments = CommandLine.arguments

        guard arguments.count == 1 else {
            print("Usage: ASTGenerator")
            exit(64)
        }

        let outputDirectory = arguments[1]
    }
}
