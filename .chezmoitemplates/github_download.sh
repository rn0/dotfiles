# shellcheck shell=bash

function github_download() {
    if [ -z "${1+x}" ]; then
        echo "GitHub repository required"
        exit 1
    fi

    REPOSITORY="$1"
    LATEST_JSON="$(curl -s "https://api.github.com/repos/$REPOSITORY/releases/latest")"

    echo "$LATEST_JSON" | \
        jq -r '.tag_name'

    RELEASE_INFO="$( \
        echo "$LATEST_JSON" | \
            jq -r ' .assets[] | select(.name | test(".*(amd64|x64).*"; "i")) | select(.name | test(".*Linux.*"; "i")) | select(.name | test(".*(zip|gz)$"; "i"))' | \
            jq -r --argjson keys '["size", "download_count", "updated_at", "browser_download_url"]' 'with_entries( select( .key as $k | $keys | index($k) ) )'
    )"
    DOWNLOAD_URL=$(echo "$RELEASE_INFO" | jq -r '.browser_download_url')
    DOWNLOAD_DIR=$(mktemp -d)
    ARCHIVE_NAME="$(basename "$DOWNLOAD_URL")"
    pushd "$DOWNLOAD_DIR" || exit

    # Make sure the temp directory gets removed on script exit.
    trap "exit 1"                 HUP INT PIPE QUIT TERM
    trap 'rm -rf "$DOWNLOAD_DIR"' EXIT

    echo "$RELEASE_INFO"
    curl -sOL "$DOWNLOAD_URL"
    ouch decompress "$ARCHIVE_NAME"
    rm "$ARCHIVE_NAME"

    SELECTED_FILE=$(sk -i -c "fd -l --type f" | awk -F. '{print $NF}')
    SELECTED_FILE=${SELECTED_FILE#/} # Remove leading slash
    INSTALLATION_LOCATION="/usr/local/bin/$SELECTED_FILE"

    if [ "$USER" = "root" ]; then
        echo "Detected root user, trying to copy $SELECTED_FILE to $INSTALLATION_LOCATION."
        cp "$SELECTED_FILE" "$INSTALLATION_LOCATION"
        chmod +x "$INSTALLATION_LOCATION"
    else
        echo "Asking for \"sudo\" permissions to finish installation."
        echo "Permission is needed to copy '$SELECTED_FILE' to '$INSTALLATION_LOCATION'"

        sudo cp "$SELECTED_FILE" "$INSTALLATION_LOCATION"
        sudo chmod +x "$INSTALLATION_LOCATION"
    fi
}
