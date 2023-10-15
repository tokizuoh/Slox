swiftlint:
	swiftlint --fix --quiet

run: swiftlint
	swiftc -parse-as-library Sources/*.swift
	./main

run-with-args: swiftlint
	swiftc -parse-as-library Sources/*.swift
	./main "${ARG}"

test: swiftlint
	swift test

.PHONY: swiftlint, run, run-with-args, test
