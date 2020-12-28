#!/bin/bash
set -e

echo "Setting paths..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TEMP_DIR="$SCRIPT_DIR/../.temp"
YAML_FILE="$TEMP_DIR/aad-pod-identity.yaml"
HCL_FILE="$SCRIPT_DIR/../azure/post-cluster-setup/aad-pod-identity.tf"

echo "Creating temp directory..."
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"

echo "Pulling down aad-pod-identity RBAC YAML..."
YAML_CONTENT="$(curl "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/deploy/infra/deployment-rbac.yaml")"

echo "Removing the '---' separators from the content..."
YAML_CONTENT="${YAML_CONTENT//---/}"

echo "Saving the content to disk..."
echo "$YAML_CONTENT" > "$YAML_FILE"

echo "Converting from YAML to HCL..."
HCL_CONTENT="$(echo "yamldecode(file(\"$YAML_FILE\"))" | terraform console)"

echo "Printing kubernetes_manifest_hcl content..."
cat > "$HCL_FILE" <<EOF
# ==========================================================
# DO NOT CHANGE THIS FILE BY HAND!
# Instead execute ./scripts/generate-aad-pod-identity-hcl.sh
# ==========================================================

resource "kubernetes_manifest_hcl" "aad_pod_identity" {
  manifest = $HCL_CONTENT

} 
EOF

terraform fmt "$HCL_FILE"
