#!/bin/bash
set -e

echo "Setting paths..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MANIFEST_PATH="$SCRIPT_DIR/../files/aad-pod-identity.yaml"

echo "Setting kubectl to use the kube config file located here: $KUBE_CONFIG_ADMIN_PATH"
export KUBECONFIG=$KUBE_CONFIG_ADMIN_PATH

echo "Checking if resources have been created before..."
EXISTING_CRD="$(kubectl get crd -o json | jq '.items[].metadata.name | select(. == "azureassignedidentities.aadpodidentity.k8s.io")')"

if [ -z "$EXISTING_CRD" ]
then
  echo "Manifest has NOT been executed yet. Running kubectl create..."
  kubectl create -f "$MANIFEST_PATH"
else
  echo "Manifest HAS been executed yet. Running kubectl replace..."
  kubectl replace -f "$MANIFEST_PATH"
fi

