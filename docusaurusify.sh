echo "This script is going to convert any repo with a docs folder and a README.md into a docusaurus project"

cp -r ../docs/* docs/
cp ../CHANGELOG.md docs/

cat slug.txt > docs/README.md
cat ../README.md >> docs/README.md
# Replace all links that have .docs/ in top level README as we flatten the dir structure
sed -i 's/(.\/docs/(.\//g' docs/README.md

# Replace logo file if it exits
LOGO_PATH=../logo.png
if test -f "$LOGO_PATH"; then
    cp $LOGO_PATH static/img/logo.png
fi

FAVICON_PATH=../favicon.ico
if test -f "$FAVICON_PATH"; then
    cp $FAVICON_PATH static/img/favicon.ico
fi

# inputs from flowzone
export REPO_NAME=$1
export ORG_NAME=$2
export DEFAULT_BRANCH=$3
export URL=$4 # Should be received from Cloudflare Pages project

# derived strings from inputs
export PROJECT_NAME=$(sed 's/^./\u&/; s/-\(.\)/ \u\1/g' <<< $REPO_NAME)
export TAGLINE='A Balena project'
export REPO_URL=https://github.com/$ORG_NAME/$REPO_NAME
