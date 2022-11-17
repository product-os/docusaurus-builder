#!/bin/sh -l

echo "Inputs: $1 $2 $3 $4"
. /app/docusaurusify.sh $1 $2 $3 $4
cd /app
npm ci
npm run build
cp -rf /app/build /github/workspace
