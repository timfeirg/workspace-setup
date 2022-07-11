.PHONY: pip-compile
pip-compile:
	pip-compile -U -vvv --output-file=requirements.txt requirements.in
