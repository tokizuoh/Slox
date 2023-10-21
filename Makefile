swiftlint:
	swiftlint --fix --quiet

run: swiftlint
	swiftc -parse-as-library -o lox Sources/Lox/*.swift
	./lox

run-with-args: swiftlint
	swiftc -parse-as-library -o lox Sources/Lox/*.swift
	./lox "${ARG}"

run-ast-generator: swiftlint
	swiftc -parse-as-library -o ast-generator Sources/ASTGenerator/*.swift
	./ast-generator "${ARG}"

test: swiftlint
	swift test

.PHONY: swiftlint, run, run-with-args, test
