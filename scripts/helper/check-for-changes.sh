#!/bin/bash
# Note: best to run from ./azure/kubernetes so that you get all of the good env vars

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/../.."

echo "Upgrading all of the terraform providers..."
(cd "$PROJECT_ROOT/azure/foundation" && terraform init --upgrade)
(cd "$PROJECT_ROOT/azure/kubernetes" && terraform init --upgrade)
(cd "$PROJECT_ROOT/azure/test-site" && terraform init --upgrade)

echo "Executing ./scripts/update-aad-pod-identity-yaml.sh"
$PROJECT_ROOT/scripts/update-aad-pod-identity-yaml.sh
