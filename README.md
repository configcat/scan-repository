# ConfigCat Scan Repository Action
This [GitHub Action](https://github.com/features/actions) is a utility that discovers ConfigCat feature flag & setting usages in your source code and uploads them to [ConfigCat](https://configcat.com).

## Configuration
1. Create a new [ConfigCat Management API credential](https://app.configcat.com/my-account/public-api-credentials) and store its values in [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) with the following names: `CONFIGCAT_API_USER`, `CONFIGCAT_API_PASS`.

2. Get the ID of your ConfigCat Config that you want to associate with your repository. The scanner will use this ID to determine which feature flags & settings to search in your source code.
    - Go to your [ConfigCat Dashboard](https://app.configcat.com), select the desired Config, and click the code references icon on one of your feature flags.
      ![code-ref](assets/code_ref.png  "code-ref")
    - Copy the Config ID from the highlighted box.
      ![config-id](assets/config_id.png  "config-id")

3. Create a new Actions workflow in your GitHub repository under the `.github/workflows` folder, and paste the following content into it.
    ```yaml
    on: [push]
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

## Available Options

| Parameter     | Description                                                                | Required   | Default             |
| ------------- | -------------------------------------------------------------------------- | ---------- | ------------------- |
| `api-host`    | ConfigCat Management API host.                                             | yes        | `api.configcat.com` |
| `api-user`    | ConfigCat Management API basic authentication username.                    | yes        |                     |
| `api-pass`    | ConfigCat Management API basic authentication password.                    | yes        |                     |
| `config-id`   | ID of the ConfigCat config to scan against.                                | yes        |                     |
| `line-count`  | Context line count before and after the reference line. (min: 1, max: 10)  | no         | 5                   |
| `sub-folder`  | Sub-folder to scan, relative to the repository root folder.                | no         |                     |
| `verbose`     | Turns on detailed logging.                                                 | no         | false               |
