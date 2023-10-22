swiftlint:
	swiftlint --fix --quiet

run: swiftlint
	swiftc -parse-as-library -o main Sources/Lox/*.swift
	./main

run-with-args: swiftlint
	swiftc -parse-as-library -o main Sources/Lox/*.swift
	./main "${ARG}"

run-ast-generator: swiftlint
	swiftc -parse-as-library -o ast-generator Sources/ASTGenerator/*.swift
	./ast-generator

test: swiftlint
	swift test

.PHONY: swiftlint, run, run-with-args, test
