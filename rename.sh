#!/bin/bash

# Usage: ./rename_project.sh OLD_NAME NEW_NAME

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 OLD_NAME NEW_NAME"
  exit 1
fi

OLD_NAME=$(echo "$1" | sed 's:/*$::')
NEW_NAME=$(echo "$2" | sed 's:/*$::')

SED_COMMAND="sed -i ''"

process_file() {
  local file="$1"
  if file --mime "$file" | grep -q 'charset=binary'; then
    echo "Skipping binary file: $file"
  else
    $SED_COMMAND "s/${OLD_NAME}/${NEW_NAME}/g" "$file"
  fi
}

export -f process_file
export OLD_NAME
export NEW_NAME
export SED_COMMAND

find . -type f -not -path '*/\.git/*' -exec bash -c 'process_file "$0"' {} \;
git add -A
find . -depth -name "*${OLD_NAME}*" -not -path '*/\.git/*' -execdir bash -c 'git mv "$1" "${1//'"${OLD_NAME}"'/'"${NEW_NAME}"'}"' _ {} \;
find . -name "*${OLD_NAME}*" -not -path '*/\.git/*' -exec bash -c 'git mv "$0" "${0//'"${OLD_NAME}"'/'"${NEW_NAME}"'}"' {} \;
find . -type f -name "*''" -delete
git add -A
git commit -m "chore: rename project"

echo "Renaming complete."
