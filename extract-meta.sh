#!/bin/bash

readme="$1"

# Use sed to match the pattern and print the matched lines to the output file
sed -n '/^---$/,/^---$/p' "$readme" | sed '1d;$d' > /app/meta.yml

# Kindly borrowed from https://stackoverflow.com/questions/5014632/how-can-i-parse-a-yaml-file-from-a-linux-shell-script
function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("export %s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

# Check if file is populated then export to environment
if [ -s $meta ]; then
    echo "Writing metadata to environment.sh"
    parse_yaml /app/meta.yml > /app/environment.sh
else
    echo "No metadata found."
    rm /app/meta.yml
    exit 1
fi
