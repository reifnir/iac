#!/bin/bash
set -ex
mkdir -p ./.temp
curl -fsSL -o ./.temp/get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 ./.temp/get_helm.sh
./.temp/get_helm.sh
