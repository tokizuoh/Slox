run:
	swiftlint --fix --quiet
	swiftc -parse-as-library Sources/*.swift && ./main

run-with-args:
	swiftlint --fix --quiet
	swiftc -parse-as-library Sources/*.swift && ./main "${ARG}"

.PHONY: run, run-with-args
