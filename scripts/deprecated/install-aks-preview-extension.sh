#!/bin/bash

# Assumes the following are installed:
#   - az cli
#   - jq

AKS_PREVIEW_INSTALLED=$(az extension list | jq '.[].name | contains("aks-preview")')

if [ "$AKS_PREVIEW_INSTALLED" == "true" ]
then
  echo "aks-preview installed."
else
  echo "aks-preview not yet installed."
  echo "installing aks-preview az extenstion..."
  az extension add --name aks-preview
fi

echo "aks-preview updating..."
az extension update --name aks-preview
echo "aks-preview extension updated."
