## Quick Start

1. **Create a repo from this template**

    In the top-right of this GitHub repo, select the green button that says "*Use this template*".

    **IMPORTANT**: When creating your repo from this template, **check the box** that says, "*Include all branches*". This is required because the hosted publication is managed on a separate branch.

2. **Configure your publication**

    * Replace the variables in `_variables.yml`
      - The `google_analytics_id` field can be left blank during development, but should be populated before publishing. See the [Publishing Guide](PUBLISHING_GUIDE.md) for more details.
    * Feel free to edit the variables in `authors.yml`.
      - Ultimately, Publishing Team will provide you with an `authors.yml` based on the contributor roles they assign for the publication, so this isn't necessary.

3. **Install Calkit and Conda**

    Install [Calkit](https://docs.calkit.org/installation/), which builds the publication, and [Miniforge](https://conda-forge.org/download/), which provides Conda. That's all: Calkit creates the publication's environment from `env.yml`, including Quarto, the first time it runs. Check everything works with:

    ```bash
    calkit run
    ```

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

    Edit `index.ipynb` to create your publication, e.g., in JupyterLab with `calkit xenv -- jupyter lab`. As you work, you can render a live preview of your changes with:

    ```bash
    make preview
    ```

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
