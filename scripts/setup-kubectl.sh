az aks get-credentials -n personal-cluster-1 -g rg-personal-cluster-1 --subscription "$AZURE_ENTERPRISE_2" --overwrite-existing
kubectl get nodes