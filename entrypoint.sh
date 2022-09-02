#!/bin/sh -l

git config --global --add safe.directory "$PWD"

EXCLUDE_KEYS="' '"
[ ! -z "${SCAN_EXCLUDE_KEYS}" ] && EXCLUDE_KEYS=${SCAN_EXCLUDE_KEYS}

echo "'$EXCLUDE_KEYS'"
echo "'$SCAN_EXCLUDE_KEYS'"

configcat scan "$GITHUB_WORKSPACE/$SCAN_SUB_DIR" \
    --config-id=${SCAN_CONFIG_ID} \
    --repo=${GITHUB_REPOSITORY} \
    --line-count=${SCAN_LINE_COUNT} \
    --file-url-template="https://github.com/$GITHUB_REPOSITORY/blob/{commitHash}/{filePath}#L{lineNumber}" \
    --commit-url-template="https://github.com/$GITHUB_REPOSITORY/commit/{commitHash}" \
    --runner="ConfigCat GitHub Action v2.1.0" \
    --upload \
    --verbose=${SCAN_VERBOSE} \
    --non-interactive \
    --exclude-flag-keys ${EXCLUDE_KEYS}