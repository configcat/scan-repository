#!/bin/sh -l

configcat scan "$GITHUB_WORKSPACE/$SCAN_SUB_DIR" \
    --config-id=${SCAN_CONFIG_ID} \
    --repo=${GITHUB_REPOSITORY} \
    --line-count=${SCAN_LINE_COUNT} \
    --file-url-template="https://github.com/$GITHUB_REPOSITORY/blob/{branch}/{filePath}#L{lineNumber}" \
    --commit-url-template="https://github.com/$GITHUB_REPOSITORY/commit/{commitHash}" \
    --runner="ConfigCat GitHub Action v1.0.0" \
    --upload \
    $([ "$SCAN_VERBOSE" = "true" ] && printf -- '--verbose')