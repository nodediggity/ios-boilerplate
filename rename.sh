#!/bin/bash

# Usage: ./rename.sh NEW_NAME

if [ "$#" -ne 1 ]; then
  echo "❌ usage: $0 new_name"
  exit 1
fi

OLD_NAME="BoilerplateApp"
NEW_NAME="${1%/}"  # Remove any trailing slashes

SED_COMMAND=("sed" "-i" "")

echo "🔍 old name: ${OLD_NAME}"
echo "🔍 new name: ${NEW_NAME}"

process_file() {
  local file="$1"
  if file --mime "$file" | grep -q 'charset=binary'; then
    echo "⚙️ skipping binary file: $file"
  else
    echo "🔄 processing file: $file"
    "${SED_COMMAND[@]}" "s/${OLD_NAME}/${NEW_NAME}/g" "$file"
  fi
}

export -f process_file
export OLD_NAME
export NEW_NAME

echo "🔄 replacing old project name with new project name in all files..."
find . -type f -not -path '*/\.git/*' -exec bash -c 'process_file "$0"' {} \;

echo "🔄 staging changes..."
git add -A

echo "🔄 renaming directories..."
find . -depth -name "*${OLD_NAME}*" -not -path '*/\.git/*' -execdir bash -c 'git mv "$1" "${1//'"${OLD_NAME}"'/'"${NEW_NAME}"'}"' _ {} \;

echo "🔄 renaming files..."
find . -name "*${OLD_NAME}*" -not -path '*/\.git/*' -exec bash -c 'git mv "$0" "${0//'"${OLD_NAME}"'/'"${NEW_NAME}"'}"' {} \;

echo "🧹 cleaning up backup files..."
find . -type f -name "*''" -delete

echo "🔄 staging renamed files..."
git add -A

echo "📝 committing changes..."
git commit -m "chore: rename project from ${OLD_NAME} to ${NEW_NAME}"

echo "✅ renaming complete."
