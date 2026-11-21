# Notebook Publication Template

This repo is a template for Jupyter notebook publications. The template produces a publication rendered and hosted by Quarto, which can be viewed at [this demo URL](https://arcadia-science.github.io/notebook-pub-template/).

## Template Documentation

All the learning resources for this template can be found in `developer-docs/`.

- [Quickstart Guide](developer-docs/QUICKSTART.md) - **The most efficient way to get started** is to follow this guide (the rest can wait)
- [Environment Setup Guide](developer-docs/ENVIRONMENT_SETUP.md) - How to set up your development environment
- [Publishing Guide](developer-docs/PUBLISHING_GUIDE.md) - How to publish your notebook publication
- [Template Architecture](developer-docs/TEMPLATE_ARCHITECTURE.md) - Understanding the template's structure

In short: your work goes in `index.ipynb` (the publication), `src/analysis/` (code it imports), and `env.yml` (packages it uses), with anything slow as a stage in `calkit.yaml`. `calkit run` reproduces it all, running only what's out of date.

---

**NOTE: When ready to publish, fill in the information below, then delete this line and everything above it.**

# [PUB-TITLE]

This code repository contains or points to all materials required for creating and hosting the publication entitled, *"[PUB-TITLE]"*.

The publication is hosted at [this URL](https://arcadia-science.github.io/[REPO-NAME]/).

## Data Description

[DESCRIPTION OF THE DATA]

## Reproduce

Install [Calkit](https://docs.calkit.org/installation/) and run the pipeline:

```bash
curl -LsSf install.calkit.org | sh
calkit run
```

This offers to install Conda if it's missing, creates the environment, and runs whatever is out of date. Or run `make setup`, which installs Calkit if it isn't yet, then Conda and the environment, without running anything. See [SETUP.qmd](pages/SETUP.qmd) for more.

## Contribute

Please see [CONTRIBUTING.qmd](pages/CONTRIBUTING.qmd).
