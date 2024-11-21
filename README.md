# OpenAPI Generator Action

This GitHub Action generates OpenAPI documentation in HTML format (or any other format supported by OpenAPI Generator) from an OpenAPI specification. You can provide the specification via a URL (to fetch it from a backend) or from an existing JSON file.

## Inputs

### `url` (Optional)
- **Description**: The URL from which the OpenAPI specification can be obtained (e.g., `http://localhost:8090/v3/api-docs`).
- **Default**: None.
- **Required**: No.
- **Behavior**: If a URL is provided, the action will download the specification from that URL.

### `spec-file` (Optional)
- **Description**: Path to the JSON file containing the OpenAPI specification.
- **Default**: None.
- **Required**: No.
- **Behavior**: If a JSON file is provided, the action will use that file directly without downloading anything.

### `output-dir`
- **Description**: The directory where the generated documentation will be saved.
- **Default**: `./docs`
- **Required**: No.

### `generator`
- **Description**: The generator to be used for generating the documentation. Possible values include `html2`, `markdown`, `pdf`, etc. Defaults to `html2`.
- **Default**: `html2`
- **Required**: No.

## Usage Example

### Using a URL

If you prefer the action to automatically download the specification from a URL, use the following example:

```yaml
name: 'Generate OpenAPI Documentation'

on:
  push:
    branches:
      - main

jobs:
  generate-docs:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Generate OpenAPI documentation from URL
        uses: diegoara96/openapi-generator-action@v1
        with:
          url: 'http://backend:8090/v3/api-docs'
          output-dir: './generated-docs'
          generator: 'html2'
```

### Using a JSON File

If you already have a JSON file with the OpenAPI specification, you can use it directly as in the following example:

```yaml
name: 'Generate OpenAPI Documentation'

on:
  push:
    branches:
      - main

jobs:
  generate-docs:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Generate OpenAPI documentation from JSON file
        uses: diegoara96/openapi-generator-action@v1
        with:
          spec-file: './spec.json'
          output-dir: './generated-docs'
          generator: 'html2'
```

### Notes
If both url and spec-file are provided, the action will prioritize the JSON file (spec-file).
If neither a URL nor a JSON file is provided, the action will fail and display an error message.
The default value for the generator is html2, but you can change it to another generator type supported by OpenAPI Generator, such as markdown, html, pdf, etc.