import Foundation

@main
final class Lox {
    static func main() {
        let arguments = CommandLine.arguments
        if arguments.count > 2 {
            print("Usage: Slox [script]")
            exit(64)
        } else if arguments.count == 2 {
            runFile(path: arguments[1])
        } else {
            // TODO
        }
    }
    
    static func runFile(path: String) {
        guard let content = try? String(contentsOfFile: path) else {
            exit(64)
        }
        // TODO
    }
}
