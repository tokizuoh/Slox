import Foundation

@main
final class Lox {
    static var hadError = false

    static func main() {
        let arguments = CommandLine.arguments
        if arguments.count > 2 {
            print("Usage: Slox [script]")
            exit(64)
        } else if arguments.count == 2 {
            runFile(path: arguments[1])
        } else {
            runPrompt()
        }
    }

    private static func runFile(path: String) {
        guard let content = try? String(contentsOfFile: path) else {
            exit(64)
        }

        run(source: content)
        if hadError {
            exit(65)
        }
    }

    private static func runPrompt() {
        while true {
            print("> ", terminator: "")
            let line = readLine()
            guard let line, !line.isEmpty else {
                break
            }

            run(source: line)
            hadError = false
        }
    }

    private static func run(source: String) {
        let scanner = Scanner(source: source)
        let tokens = scanner.scanTokens()

        // TODO
        tokens.forEach { token in
            print(token.type)
        }
    }

    static func error(line: Int, message: String) {
        report(line: line, file: "", message: message)
    }

    private static func report(line: Int, file: String, message: String) {
        print("[line: \(line)] Error \(file): \(message)")
        hadError = true
    }
}
