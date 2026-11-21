# Tools run in the project's environment (env.yml), which includes Quarto.

.PHONY: lint
lint:
	calkit xenv -n main -- ruff check --exit-zero .
	calkit xenv -n main -- ruff format --check .

.PHONY: format
format:
	calkit xenv -n main -- ruff check --fix .
	calkit xenv -n main -- ruff format .

.PHONY: pre-commit
pre-commit:
	calkit xenv -n main -- pre-commit run --all-files

.PHONY: test
test:
	calkit xenv -n main -- pytest -v .

.PHONY: execute
execute:
	# Run the pipeline in calkit.yaml: whatever is out of date with its code,
	# data, or environment, ending with executing index.ipynb
	calkit run

.PHONY: preview
preview:
	calkit xenv -n main -- quarto preview

.PHONY: execute-demo
execute-demo:
	# This command is only necessary when changes are made to the demo notebook
	# for development of the notebook pub template.
	calkit xenv -n main -- quarto render examples/demo.ipynb --execute

.PHONY: update-theme
update-theme:
	calkit xenv -n main -- quarto update extension Arcadia-Science/notebook-pub-theme --no-prompt
