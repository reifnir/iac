#!/bin/bash
set -e

function wait-for-daemonset {
  DAEMONSET="$1"
  NAMESPACE="$2"

  echo "Waiting for up to 60 seconds for daemonset '$DAEMONSET' in namespace '$NAMESPACE' to be available..."
  RETRIES=20
  while [[ $RETRIES -ge 0 ]];do
    sleep 3
    READY=$(kubectl -n $DAEMONSET get daemonset $NAMESPACE -o jsonpath="{.status.numberReady}")
    DESIRED=$(kubectl -n $DAEMONSET get daemonset $NAMESPACE -o jsonpath="{.status.desiredNumberScheduled}")
    echo "  Count desired/ready: $DESIRED/$READY"
    if [[ $READY -eq $DESIRED ]];then
      echo "  Daemonset successfully started."
      break
    fi
    ((RETRIES--))
  done
}


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

echo "Wait until the Node Managed Identity daemonset is ready..."
wait-for-daemonset "nmi" "default"

echo "Wait until the Managed Identity Controller deployment is ready..."
kubectl wait --for=condition=available --timeout=60s deployment mic
