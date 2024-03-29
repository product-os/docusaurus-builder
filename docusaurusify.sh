#!/usr/bin/env bash

if [ "$DEV" = 'true' ] ; then
    export GITHUB_WORKSPACE="/app/dev"
else
    echo "Converting $2/$1 repo docs into a docusaurus project"
fi

if [ -d "$GITHUB_WORKSPACE/balena-docs" ]; then
    DOCS_PATH=$GITHUB_WORKSPACE/balena-docs/
else
    DOCS_PATH=$GITHUB_WORKSPACE/docs/
fi
echo "Chosen path for docs: $DOCS_PATH"

# Cleaning existing docs of docusaurus builder 
rm -rf /app/docs/**

# Copy docs to build folder
cp -r $DOCS_PATH* /app/docs/

# Copy Changelog to docs build folder
# https://github.com/product-os/docusaurus-theme/issues/24
# cp $GITHUB_WORKSPACE/CHANGELOG.md /app/docs/

# Copy README if it doesn't exists
if [ ! -e "/app/docs/README.md" ]; then
    cp $GITHUB_WORKSPACE/README.md /app/docs/README.md
fi

# Replace all links that have .docs/ in top level README as we flatten the dir structure
sed -i -r 's|\((\./)?docs/|\(\./|g' /app/docs/README.md

# Replace logo file if it exits
LOGO_PATH=$GITHUB_WORKSPACE/logo.png
if test -f "$LOGO_PATH"; then
    cp $LOGO_PATH /app/static/img/logo.png
fi

FAVICON_PATH=$GITHUB_WORKSPACE/favicon.ico
if test -f "$FAVICON_PATH"; then
    cp $FAVICON_PATH /app/static/img/favicon.ico
fi

if [ "$DEV" = 'true' ] ; then
    export PROJECT_NAME="Development Build"
    export DEV_REPO_URL="https://localhost"
    export URL="https://localhost"
else
    # inputs from flowzone
    export REPO_NAME=$1
    export ORG_NAME=$2
    export DEFAULT_BRANCH=$3
    export URL=$4 # Should be received from Cloudflare Pages project

    # derived strings from inputs
    export PROJECT_NAME=$(sed 's/^./\u&/; s/-\(.\)/ \u\1/g' <<<$REPO_NAME)
    export REPO_URL=https://github.com/$ORG_NAME/$REPO_NAME
fi