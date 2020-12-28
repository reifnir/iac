#!/bin/bash
set -e

echo "Setting paths..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

OUTPUT_FILE="$SCRIPT_DIR/../files/aad-pod-identity.yaml"

echo "Downloading content of current version of aad-pod-identity.yaml..."
CONTENT="$(curl "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/deploy/infra/deployment-rbac.yaml")"

echo "Writing content and warning to disk..."
cat > "$OUTPUT_FILE" <<EOF
# ==========================================================
# DO NOT CHANGE THIS FILE BY HAND!
# Instead execute ./scripts/update-aad-pod-identity-yaml.sh
# If the file is different, check new version into source
# ==========================================================
$CONTENT
EOF
