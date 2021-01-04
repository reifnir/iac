#!/bin/bash
set -ex

echo "SUBSCRIPTION_ID=$SUBSCRIPTION_ID"
echo "RESOURCE_GROUP=$RESOURCE_GROUP"
echo "APP_GATEWAY_NAME=$APP_GATEWAY_NAME"
echo "IDENTITY_RESOURCE_ID=$IDENTITY_RESOURCE_ID" # azurerm_user_assigned_identity.testIdentity.id
echo "IDENTITY_CLIENT_ID=$IDENTITY_CLIENT_ID "    # azurerm_user_assigned_identity.testIdentity.client_id

# curl https://baltocdn.com/helm/signing.asc | apt-key add -
# echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
helm repo add application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/
helm repo update

echo "Writing AGIC helm config to ./.temp/helm-config.yaml..."
cat > ./.temp/helm-config.yaml <<EOF
# This file contains the essential configs for the ingress controller helm chart

# Verbosity level of the App Gateway Ingress Controller
# 1	Default log level; shows startup details, warnings and errors
# 3	Extended information about events and changes; lists of created objects
# 5	Logs marshaled objects; shows sanitized JSON config applied to ARM
verbosityLevel: 3

################################################################################
# Specify which application gateway the ingress controller will manage
#
appgw:
    subscriptionId: $SUBSCRIPTION_ID
    resourceGroup: $RESOURCE_GROUP
    name: $APP_GATEWAY_NAME
    usePrivateIP: false

    # Setting appgw.shared to "true" will create an AzureIngressProhibitedTarget CRD.
    # This prohibits AGIC from applying config for any host/path.
    # Use "kubectl get AzureIngressProhibitedTargets" to view and change this.
    shared: false

################################################################################
# Specify which kubernetes namespace the ingress controller will watch
# Default value is "default"
# Leaving this variable out or setting it to blank or empty string would
# result in Ingress Controller observing all acessible namespaces.
#
# kubernetes:
#   watchNamespace: <namespace>

################################################################################
# Specify the authentication with Azure Resource Manager
#
# Two authentication methods are available:
# - Option 1: AAD-Pod-Identity (https://github.com/Azure/aad-pod-identity)
armAuth:
    type: aadPodIdentity
    identityResourceID: $IDENTITY_RESOURCE_ID
    identityClientID:  $IDENTITY_CLIENT_ID

## Alternatively you can use Service Principal credentials
# armAuth:
#    type: servicePrincipal
#    secretJSON: <<Generate this value with: "az ad sp create-for-rbac --subscription <subscription-uuid> --sdk-auth | base64 -w0" >>

################################################################################
# Specify if the cluster is RBAC enabled or not
rbac:
    enabled: true
EOF

echo "Printing AGIC helm config..."
cat ./.temp/helm-config.yaml

echo "Checking whether AGIC is already installed..."
INSTALLED_CHART_NAME='default-agic'
AGIC_STATE="$(helm list -o json | jq ".[] | select(.name == \"$INSTALLED_CHART_NAME\") | .")"


if [ -z "$AGIC_STATE" ]
then
  echo "App Gateway Ingress controller has never been installed. Performing first installation..."
  helm install "$INSTALLED_CHART_NAME" -f ./.temp/helm-config.yaml application-gateway-kubernetes-ingress/ingress-azure
else
  INSTALLED_APP_VERSION="$(echo $AGIC_STATE | jq .app_version -r)"
  DEPLOYABLE_APP_VERSION="$(helm search repo application-gateway-kubernetes-ingress -o json | jq '.[] | select(.name == "application-gateway-kubernetes-ingress/ingress-azure") | .app_version' -r)"

  echo "application-gateway-kubernetes-ingress/ingress-azure already installed..."
  echo "  installed app version: $INSTALLED_APP_VERSION"
  echo "  deployable app version: $DEPLOYABLE_APP_VERSION"

  if [ "$INSTALLED_APP_VERSION" != "$DEPLOYABLE_APP_VERSION" ]
  then
    echo "  App versions are different, so running helm upgrade..."
    helm upgrade "$INSTALLED_CHART_NAME" application-gateway-kubernetes-ingress/ingress-azure
  else
    echo "  App versions are the same. Exiting script."
  fi
fi
