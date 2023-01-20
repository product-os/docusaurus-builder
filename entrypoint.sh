#!/bin/sh -l

if [ "$DEV" = 'true' ] ; then
    echo "Development mode is enabled"
    export PROJECT_NAME="development build"
    export URL="https://localhost"
    cp -rf /app/dev/docs /app
    cp -rf /app/dev/static /app/docs || true
    cp -u /app/dev/README.md /app/docs/README.md || true
else
    echo "Inputs: $1 $2 $3 $4"  
    . /app/docusaurusify.sh $1 $2 $3 $4
fi

cd /app

if [ "$DEV" = 'true' ] ; then
    echo "Serving locally..."
    npm run start
else
    # npm ci
    npx docusaurus build
    cp -rf /app/build /github/workspace
fi
