#!/bin/sh -l

if [ "$DEV" = 'true' ] ; then
    echo "Development mode is enabled"
    . /app/docusaurusify.sh
    cd /app
    echo "Serving locally..."
    npm run start
else
    echo "Inputs: $1 $2 $3 $4"
    . /app/docusaurusify.sh $1 $2 $3 $4
    cd /app
    npx docusaurus build
    if [ $? -ne 0 ]; then
        echo "An error during docusaurus build. Exiting with status code 1."
        exit 1
    fi
    cp -rf /app/build /github/workspace
fi
