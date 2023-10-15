run:
	swiftc -parse-as-library Sources/Lox.swift && ./Lox
	swiftlint --fix --quiet

run-with-args:
	swiftc -parse-as-library Sources/Lox.swift && ./Lox "${ARG}"
	swiftlint --fix --quiet

.PHONY: run, run-with-args
