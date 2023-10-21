swiftlint:
	swiftlint --fix --quiet

run: swiftlint
	swiftc -parse-as-library Sources/Lox/*.swift
	./main

run-with-args: swiftlint
	swiftc -parse-as-library Sources/Lox/*.swift
	./main "${ARG}"

test: swiftlint
	swift test

.PHONY: swiftlint, run, run-with-args, test
