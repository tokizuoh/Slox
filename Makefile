run:
	swiftlint --fix
	swift run Slox "${ARG}"

.PHONY: run
