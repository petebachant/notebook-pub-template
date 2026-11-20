# Tools run in the project's environment (env.yml), which includes Quarto.

.PHONY: lint
lint:
	calkit xenv -- ruff check --exit-zero .
	calkit xenv -- ruff format --check .

.PHONY: format
format:
	calkit xenv -- ruff check --fix .
	calkit xenv -- ruff format .

.PHONY: pre-commit
pre-commit:
	calkit xenv -- pre-commit run --all-files

.PHONY: test
test:
	calkit xenv -- pytest -v .

.PHONY: execute
execute:
	# Run the pipeline in calkit.yaml: whatever is out of date with its code,
	# data, or environment, ending with executing index.ipynb
	calkit run

.PHONY: preview
preview:
	calkit xenv -- quarto preview

.PHONY: execute-demo
execute-demo:
	# This command is only necessary when changes are made to the demo notebook
	# for development of the notebook pub template.
	calkit xenv -- quarto render examples/demo.ipynb --execute

.PHONY: update-theme
update-theme:
	calkit xenv -- quarto update extension Arcadia-Science/notebook-pub-theme --no-prompt
