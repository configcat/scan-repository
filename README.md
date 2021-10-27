# ConfigCat Scan Repository Action
This [GitHub Action](https://github.com/features/actions) is a utility that discovers ConfigCat feature flag & setting usages in your source code and uploads them to [ConfigCat](https://configcat.com).

For more information about repository scanning, see our [documentation](https://configcat.com/docs/advanced/code-references/overview).

## Configuration
1. Create a new [ConfigCat Management API credential](https://app.configcat.com/my-account/public-api-credentials) and store its values in [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) with the following names: `CONFIGCAT_API_USER`, `CONFIGCAT_API_PASS`.

    ![secrets](https://raw.githubusercontent.com/configcat/scan-repository/main/assets/secrets.png  "secrets")

2. [Get the ID of your ConfigCat Config](https://configcat.com/docs/advanced/code-references/overview#config-id) that you want to associate with your repository. The scanner will use this ID to determine which feature flags & settings to search for in your source code.

3. Create a new Actions workflow in your GitHub repository under the `.github/workflows` folder, and paste the following content into it.
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
          uses: actions/checkout@v2
        - name: Scan & upload
          uses: configcat/scan-repository@v1
          with:
            api-user: ${{ secrets.CONFIGCAT_API_USER }}
            api-pass: ${{ secrets.CONFIGCAT_API_PASS }}
            config-id: PASTE-YOUR-CONFIG-ID-HERE
    ```

4. Commit & push your action.

The above example configures a workflow that executes the scan and code references upload on every git `push` event.
The code references will be uploaded for each branch in your repository that triggers the workflow. 

## Available Options

| Parameter     | Description                                                                | Required   | Default             |
| ------------- | -------------------------------------------------------------------------- | ---------- | ------------------- |
| `api-host`    | ConfigCat Management API host.                                             | &#9745;    | `api.configcat.com` |
| `api-user`    | ConfigCat Management API basic authentication username.                    | &#9745;    |                     |
| `api-pass`    | ConfigCat Management API basic authentication password.                    | &#9745;    |                     |
| `config-id`   | ID of the ConfigCat config to scan against.                                | &#9745;    |                     |
| `line-count`  | Context line count before and after the reference line. (min: 1, max: 10)  |            | 5                   |
| `sub-folder`  | Sub-folder to scan, relative to the repository root folder.                |            |                     |
| `verbose`     | Turns on detailed logging.                                                 |            | false               |
