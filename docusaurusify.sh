echo "This script is going to convert any repo with a docs folder and a README.md into a docusaurus project"

cp -r ../docs/* docs/
cp ../CHANGELOG.md docs/

cat slug.txt > docs/README.md
cat ../README.md >> docs/README.md
# Replace all links that have .docs/ in top level README as we flatten the dir structure
sed -i 's/(.\/docs/(.\//g' docs/README.md

# inputs from flowzone
REPO_NAME=$1
ORG_NAME=$2
DEFAULT_BRANCH=$3
URL=$4 # Should be received from Cloudflare Pages project

# derived strings from inputs
PROJECT_NAME=$(sed 's/^./\u&/; s/-\(.\)/ \u\1/g' <<< $REPO_NAME)
TAGLINE='A Balena project'
REPO_URL=https://github.com/$ORG_NAME/$REPO_NAME

# FAVICON=defaults to balena
echo $PROJECT_NAME

# Replace variables with their values in the config

sed -i "s|\$REPO_URL|${REPO_URL}|g"  docusaurus.config.js
sed -i "s|\$PROJECT_NAME|${PROJECT_NAME}|g"  docusaurus.config.js
sed -i "s|\$EDIT_URL|${EDIT_URL}|g"  docusaurus.config.js
sed -i "s|\$DEFAULT_BRANCH|${DEFAULT_BRANCH}|g"  docusaurus.config.js
sed -i "s|\$TAGLINE|${TAGLINE}|g"  docusaurus.config.js
sed -i "s|\$URL|${URL}|g"  docusaurus.config.js

# Check that all variables have been replaced
VARIABLE_COUNT=$(grep -E '\$' docusaurus.config.js  | wc -l)
echo $VARIABLE_COUNT
