# ConfigCat Scan Repository & Feature Flag Sync Action
This [GitHub Action](https://github.com/features/actions) helps you get rid of technical debt by scanning the source code and highlighting the feature flag usages for each feature flag on the [ConfigCat Dashboard](https://app.configcat.com).

For more information about repository scanning, see our [documentation](https://configcat.com/docs/advanced/code-references/overview).

[ConfigCat](https://configcat.com) is a hosted service for feature flag and configuration management. It enables you to decouple feature releases from code deployments.

## Setup
1. Create a new [ConfigCat Management API credential](https://app.configcat.com/my-account/public-api-credentials) and store its values in [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) with the following names: `CONFIGCAT_API_USER`, `CONFIGCAT_API_PASS`.

    ![secrets](https://raw.githubusercontent.com/configcat/scan-repository/main/assets/secrets.png  "secrets")

2. [Get the ID of your ConfigCat Config](https://configcat.com/docs/advanced/code-references/overview#config-id) that you want to associate with your repository. The scanner will use this ID to determine which feature flags & settings to search for in your source code.

3. Create a new Actions workflow in your GitHub repository under the `.github/workflows` folder, and put the following snippet into it.
Don't forget to replace the `PASTE-YOUR-CONFIG-ID-HERE` value with your actual Config ID.
    ```yaml
    on: [push]
    name: Code references
    jobs:
      scan-repo:
        runs-on: ubuntu-latest
        name: Scan repository for code references
        steps:
        - name: Checkout
          uses: actions/checkout@v4
        - name: Scan & upload
          uses: configcat/scan-repository@v2
          with:
            api-user: ${{ secrets.CONFIGCAT_API_USER }}
            api-pass: ${{ secrets.CONFIGCAT_API_PASS }}
            config-id: PASTE-YOUR-CONFIG-ID-HERE
            # line-count: 5             # optional
            # timeout: 2000             # optional
            # sub-folder: src           # optional
            # exclude-keys: >           # optional
            #   flag_key_to_exclue_1
            #   flag_key_to_exclue_2
            # alias-patterns: (\w+) = :CC_KEY,const (\w+) = feature_flags\.enabled\(:CC_KEY\) # optional, comma delimited alias patterns
            # usage-patterns: feature_flags\.enabled\(:CC_KEY\)   # optional, comma delimited flag key usage patterns
            # verbose: true             # optional
    ```

4. Commit & push your action.

The above example configures a workflow that executes the scan and code references upload on every git `push` event.
Scan reports are uploaded for each branch of your repository that triggers the workflow. 

## Available Options

| Parameter        | Description                                                                | Required   | Default             |
| ---------------- | -------------------------------------------------------------------------- | ---------- | ------------------- |
| `api-host`       | ConfigCat Management API host.                                             | &#9745;    | `api.configcat.com` |
| `api-user`       | [ConfigCat Management API basic authentication username](https://app.configcat.com/my-account/public-api-credentials). | &#9745;    |        |
| `api-pass`       | [ConfigCat Management API basic authentication password](https://app.configcat.com/my-account/public-api-credentials). | &#9745;    |        |
| `config-id`      | ID of the ConfigCat config to scan against.                                | &#9745;    |                     |
| `line-count`     | Context line count before and after the reference line. (min: 1, max: 10)  |            | 4                   |
| `timeout`        | Scan timeout in seconds (default: 1800, min: 60)                           |            | 1800                |
| `sub-folder`     | Sub-folder to scan, relative to the repository root folder.                |            |                     |
| `exclude-keys`   | List of feature flag keys that must be excluded from the scan report.      |            |                     |
| `alias-patterns` | Comma delimited list of custom regex patterns used to search for additional aliases. |  |                     |
| `usage-patterns` | Comma delimited list of custom regex patterns that describe additional feature flag key usages. |  |                     |
| `verbose`        | Turns on detailed logging.                                                 |            | false               |
