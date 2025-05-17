#!/bin/bash
set -euo pipefail

# Find all secret files (even if ignored), excluding already encrypted
secret_files=$(find . \
  -type f \
  \( -name "*.tfvars" -o -name "*.tfvars.json" -o -name "*.tfstate" -o -name "*.tfstate.backup" -o -name ".env" \) \
  ! -name "*.enc")

# Track encrypted files to add after loop
enc_files_to_add=()

for filename in $secret_files; do
    enc_file="${filename}.enc"

    # Skip if already encrypted version exists
    [[ -f "$enc_file" ]] && continue

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
