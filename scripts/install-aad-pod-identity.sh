#!/bin/bash
set -ex

# Assumes the following are installed:
#   - kubectl
#   - jq

# Debugging is harder than it seems it should be
# docker run -v "$(pwd):/src" -it microsoft/azure-cli:latest
# cd /src && apk add nano curl && curl -Lo /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x /usr/bin/kubectl && export KUBE_CONFIG_ADMIN_PATH="/src/.temp/kube-config-admin"


function wait-for-daemonset {
  DAEMONSET="$1"
  NAMESPACE="$2"
  echo "Waiting for up to 60 seconds for daemonset '$DAEMONSET' in namespace '$NAMESPACE' to be available..."

  RETRIES=20
  while [[ $RETRIES -ge 0 ]];do
    sleep 3
    READY=$(kubectl -n $NAMESPACE get daemonset $DAEMONSET -o jsonpath="{.status.numberReady}")
    DESIRED=$(kubectl -n $NAMESPACE get daemonset $DAEMONSET -o jsonpath="{.status.desiredNumberScheduled}")
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
echo "  SCRIPT_DIR=$SCRIPT_DIR"
MANIFEST_PATH="$SCRIPT_DIR/../files/aad-pod-identity.yaml"
echo "  MANIFEST_PATH=$MANIFEST_PATH"

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
