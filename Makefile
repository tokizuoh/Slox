run:
	swiftlint --fix
	swiftc -parse-as-library Sources/Lox.swift && ./Lox

run-with-args:
	swiftlint --fix
	swiftc -parse-as-library Sources/Lox.swift && ./Lox "${ARG}"

.PHONY: run, run-with-args
