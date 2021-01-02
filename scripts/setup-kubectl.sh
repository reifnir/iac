az aks get-credentials -n personal-cluster-1 -g rg-personal-cluster-1 --subscription "$TF_VAR_azure_subscription" --overwrite-existing --admin
kubectl get nodes