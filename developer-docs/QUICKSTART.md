## Quick Start

1. **Create a repo from this template**

    In the top-right of this GitHub repo, select the green button that says "*Use this template*".

    **IMPORTANT**: When creating your repo from this template, **check the box** that says, "*Include all branches*". This is required because the hosted publication is managed on a separate branch.

2. **Configure your publication**

    * Replace the variables in `_variables.yml`
      - The `google_analytics_id` field can be left blank during development, but should be populated before publishing. See the [Publishing Guide](PUBLISHING_GUIDE.md) for more details.
    * Feel free to edit the variables in `authors.yml`.
      - Ultimately, Publishing Team will provide you with an `authors.yml` based on the contributor roles they assign for the publication, so this isn't necessary.

3. **Install Calkit and build the publication**

    Install [Calkit](https://docs.calkit.org/installation/), which builds the publication, then build it:

    ```bash
    curl -LsSf install.calkit.org | sh  # Windows: see the link above
    calkit run
    ```

    That's all. The first `calkit run` offers to install Conda (Miniforge) if this machine doesn't have it, then creates the publication's environment from `env.yml`, including Quarto. `make setup` does the same without building, installing Calkit first if it's missing.

4. **Know where your work goes**

    | What | Where |
    | --- | --- |
    | The publication: prose, figures, and the code that makes them | `index.ipynb` |
    | Code you import into the notebook | `src/analysis/` |
    | Packages you use | `env.yml` (no version pins needed; Calkit locks them) |
    | Anything slow, e.g., processing data or training a model | a stage in `calkit.yaml` that writes results the notebook reads |
    | The questions the pub answers | `questions` in `calkit.yaml` (optional) |

    Everything else, e.g., `_quarto.yml`, `_extensions/`, `_freeze/`, and `pages/`, is publishing machinery you can leave alone. See [Environment Setup](ENVIRONMENT_SETUP.md) for working with the environment.

5. **Register your publication**

    If you intend to publish your analysis, fill out the "*Kick off a new pub*" form on the AirTable [Publishing toolkit](https://airtable.com/appN7KQ55bT6HHfog/pagm69ti1kZK1GhBx).

6. **Create your publication**

    Edit `index.ipynb` to create your publication, e.g., in JupyterLab with `calkit xenv -n main -- jupyter lab`. As you work, you can render a live preview of your changes with:

    ```bash
    make preview
    ```

    Numbers in the text should come from the analysis rather than being typed in, so they can't drift from it:

    - **A number the notebook computes:** show it with an inline expression from a variable an earlier cell defines, e.g., `` `{python} f"{r2:.2f}"` ``. Inline expressions are evaluated in order, so the cell has to come before the text.
    - **A number quoted from a reference,** e.g., a parameter you reuse or a result you compare against: record it with `calkit new ref-value <key> <name> --value 0.1 --page 4 --context "the passage it's in"`, which checks it against the reference's PDF, then show it with `{{< ckrefval <key> <name> >}}`, and cite the reference as usual.

    `calkit check repro -c numbers` lists numbers typed into the text with nothing behind them, and `-c refvals` checks quoted values against their references. Calkit adds `_extensions/calkit/` and `.calkit/reference-values/` when you quote a value; commit them.

    When you're done with a change, run `calkit run`, which re-executes the notebook top to bottom if anything it depends on changed, so what's published comes from a clean run. Then commit your changes to a development branch and merge them into `main` using our usual PR-based workflow. A check on each pull request fails if something committed is out of date with the code that makes it.

    As you work, please be careful to avoid modifying any files in the following directories:

      - `/_extensions` (Quarto extensions)
      - `/_freeze` (Generated execution results)
      - `/_site` (Generated website files)

    These files are all either necessary to build the publication or are automatically generated during the publication process.

7. **Link your additional assets**

    Pubs on [The Stacks](https://thestacks.org) show a row of "Additional assets." The code, data, protocols, and other artifacts that accompany the work. To get
    the same row on your pub, list them in the YAML front matter of `index.ipynb`
    (the first cell, alongside `title` and `date`):

    ```yaml
    additional-assets:
      - type: code
        url: https://github.com/Arcadia-Science/my-pub
      - type: protocol
        url: https://www.protocols.io/view/...
        name: Cell culture protocol

    ```

    Each entry needs a `type` and a `url`. The available
    types, matching The Stacks:

    | `type` | Renders as |
    | --- | --- |
    | `code` | Code |
    | `data` | Data |
    | `code-and-data` | Code + data |
    | `material` | Material |
    | `protocol` | Protocol |
    | `3d-printing` | 3D printing design |
    | `companion-pub` | Companion pub |
    | `other` | Other |

    Add an optional `name` to label an asset yourself. You'll want this whenever a
    pub links more than one asset of the same type, so that readers can tell two
    protocols apart. Omit `additional-assets` entirely and no row is rendered.

    Write each `url` out in full. Quarto's `{{< var >}}` shortcodes are **not**
    expanded in these values, so `https://github.com/{{< var pub.org >}}/...`
    would render a broken link.

8. **Publishing**

    See the [Publishing Guide](PUBLISHING_GUIDE.md) for complete instructions on the publishing process.
