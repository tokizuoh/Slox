swiftlint:
	swiftlint --fix --quiet

run: swiftlint
	swiftc -parse-as-library Sources/*.swift
	./main

run-with-args: swiftlint
	swiftc -parse-as-library Sources/*.swift
	./main "${ARG}"

.PHONY: swiftlint, run, run-with-args
