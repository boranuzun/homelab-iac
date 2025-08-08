#!/bin/bash
set -euo pipefail

# Array of file extensions to check
FILE_EXTENTIONS=(
  "*.tfvars"
  "*.tfvars.json"
  "*.tfstate"
  "*.tfstate.backup"
  ".env"
)

# Find all secret files (even if ignored), excluding already encrypted
secret_files=$(find . \
  -type f \
  \( -name "${FILE_EXTENTIONS[0]}" \
  -o -name "${FILE_EXTENTIONS[1]}" \
  -o -name "${FILE_EXTENTIONS[2]}" \
  -o -name "${FILE_EXTENTIONS[3]}" \
  -o -name "${FILE_EXTENTIONS[4]}" \) \
  ! -name "*.enc")

# Track encrypted files to add after loop
enc_files_to_add=()

for filename in $secret_files; do
    enc_file="${filename}.enc"

    # Remove old encrypted version if it exists
    if [[ -f "$enc_file" ]]; then
        rm -f "$enc_file"
    fi

    # Skip if file already contains SOPS metadata
    grep -q 'sops:' "$filename" && continue

    # Encrypt and store output
    sops --encrypt "$filename" > "$enc_file"
    enc_files_to_add+=("$enc_file")
done

# Stage the new encrypted files
if [ ${#enc_files_to_add[@]} -gt 0 ]; then
    git add "${enc_files_to_add[@]}"
fi
