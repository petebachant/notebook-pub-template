# Environment Setup Guide

This document explains how the publication's environment works, for developing and reproducing notebook publications.

## The environment

The publication runs in a Conda environment defined in `env.yml`, which includes Quarto. You don't create or activate it yourself: [Calkit](https://docs.calkit.org) creates it in `.conda-envs/main` the first time it's needed, and updates it whenever `env.yml` changes. You'll need [Calkit](https://docs.calkit.org/installation/) installed; the first `calkit run` offers to install Conda if it's missing.

List the packages your publication uses in `env.yml` without pinning their versions. When Calkit creates the environment, it records the exact versions of everything installed, for every platform, in `.calkit/env-locks/`. Commit those files: anyone reproducing the publication, on any operating system, then gets the same versions you used.

The code in `src/` is installed into the environment as the `analysis` package, so the notebook can `import analysis`, and editing it is picked up without reinstalling.

## Running things in the environment

Run any command in the environment with `calkit xenv --`, e.g.:

```bash
calkit xenv -- jupyter lab
calkit xenv -- python scripts/process.py
```

To use the environment in your editor, e.g., VS Code, select the Python interpreter in `.conda-envs/main`.

Optionally, install the [pre-commit](https://pre-commit.com/) hooks:

```bash
calkit xenv -- pre-commit install
```

Test your setup with `make preview`. Your pub will open up in your browser.

Afterwards, create a branch to work on (don't commit to `main` directly).

## Pub Development

When working with Jupyter notebooks:

1. Edit `index.ipynb` as your main publication file
2. Use `make preview` to see changes in real-time
3. Run `calkit run` (or `make execute`) before committing, which re-executes the notebook if anything it depends on changed, updating its outputs and `_freeze/`

Put anything slow, e.g., processing data or training a model, in a pipeline stage in `calkit.yaml` rather than in the notebook. Calkit reruns a stage only when its own code or inputs change, so iterating on the notebook stays quick. For example, `calkit xr scripts/process.py` adds a stage for a script, detecting the files it reads and writes.

## Other Commands

The Makefile provides several useful commands for development:

- `make lint`: Run linting checks using ruff
- `make format`: Automatically format code using ruff
- `make pre-commit`: Run all pre-commit hooks
- `make test`: Run pytest tests, if they exist
