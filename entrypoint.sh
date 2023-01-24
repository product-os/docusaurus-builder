#!/bin/sh -l

# Remove Docusaurus default README.md
# rm /app/docs/README.md

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
    cp -rf /app/build /github/workspace
fi
