#!/bin/bash

set -e

# Assuming this script is run in a subdirectory of root
cd "$(dirname "$0")/.."
LOG_FILE="change-log.md"
repo="https://github.com/soulhotel/paruse"

currentrelease=$(
    curl -sL "https://api.github.com/repos/soulhotel/paruse/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"tag_name": "([^"]+)".*/\1/'
)
fetchedrelease=$(
    grep -m 1 -E '^## <ins> [0-9]+\.[0-9]+(\.[a-z]+)? </ins>' "$LOG_FILE" |
    head -n 1 |
    sed -E 's/## <ins> (.*) <\/ins>/\1/' |
    tr -d ' '
)
# NOTES=$(
#     sed -n "/^## <ins> ${fetchedrelease} <\/ins>/{
#         :a
#         n
#         /^## <ins> [0-9]+\.[0-9]+(\.[a-z]+)? <\/ins>/q
#         p
#     }" "$LOG_FILE" |
#     sed '/^$/N;/\n$/P;D' |
#     sed 's/^/    /'
# )

if [[ "$fetchedrelease" == "$currentrelease" ]]; then
    VERIFIED_STATUS="unverified"
    NEXT_RELEASE_MSG="$LOG_FILE release ($fetchedrelease) matches whats already on github. Double check $LOG_FILE before proceeding."
else
    VERIFIED_STATUS="verified"
    NEXT_RELEASE_MSG="Release update from $currentrelease to $fetchedrelease"
fi

menu() {
    clear
    echo "repo: $repo"
    echo "current release: $currentrelease (verified)"
    echo "change log release: $fetchedrelease ($VERIFIED_STATUS)"
#     echo
#     echo "$NOTES"
    echo
    echo "$NEXT_RELEASE_MSG"
    echo
    echo "1. commit next release"
    echo "2. release next release"
    echo "3. submit to aur"
    echo "q. quit"
    echo ""
    echo -n "What will it be?: "
}

pre_commit() {
    if [[ "$VERIFIED_STATUS" == "verified" ]]; then
        echo "Running: git add . && git commit -m \"$fetchedrelease\" && git push origin main"
        git add .
        git commit -m "$fetchedrelease"
        git push origin main
    else
        echo "skipping, double-check $LOG_FILE."
    fi
    echo "Press Enter to continue..."
    read
}

make_release() {
    if [[ "$VERIFIED_STATUS" == "verified" ]]; then
        echo "enter the release notes"
        NOTES=""
        local line
        while IFS= read -r line; do
            if [[ -z "$line" ]]; then
                break
            fi
            NOTES+="$line"$'\n'
        done
        NOTES=$(echo -n "$NOTES" | sed '$s/\n$//')
        if [[ -z "$NOTES" ]]; then
            echo "no notes added"
        else
            gh release create "$fetchedrelease" \
                --title "$fetchedrelease" \
                --notes "$NOTES" \
                --draft=false \
                --prerelease=false
        fi
    else
        echo "skipping, double-check $LOG_FILE."
    fi
    echo "Press Enter to continue..."
    read
}

submit_aur() {
    echo "Press Enter to continue..."
    read
}

while true; do
    menu
    read -r choice
    case "$choice" in
        1) clear; pre_commit ;;
        2) clear; make_release ;;
        3) clear; submit_aur ;;
        q|Q|"") clear; exit 0 ;;
        *)
            echo "Invalid option"
            sleep 1
            ;;
    esac
done