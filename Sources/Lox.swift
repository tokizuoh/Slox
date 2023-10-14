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
            runPrompt()
        }
    }

    private static func runFile(path: String) {
        guard let content = try? String(contentsOfFile: path) else {
            exit(64)
        }

        run(source: content)
    }

    private static func runPrompt() {
        while true {
            print("> ", terminator: "")
            let line = readLine()
            guard let line, !line.isEmpty else {
                break
            }

            run(source: line)
        }
    }

    private static func run(source: String) {
        // TODO
        print(source)
    }
}
