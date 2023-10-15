run:
	swiftlint --fix --quiet
	swiftc -parse-as-library Sources/*.swift && ./Lox

run-with-args:
	swiftlint --fix --quiet
	swiftc -parse-as-library Sources/*.swift && ./Lox "${ARG}"

.PHONY: run, run-with-args
