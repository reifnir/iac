# iac
Infrastructure-as-code repo

## Pre-requisites
* Ensure that you enable the ingress controller add-on
  1. https://docs.microsoft.com/en-us/azure/application-gateway/tutorial-ingress-controller-add-on-new

## Done
* Manually create service principal used by GitLab CI and give just enough permission
  * the tricky part was...
    * go into Azure Active Directory
    * search for the app id/guid of the sp
    * App registrations version of the sp's ID
    * API permissions
    * add a permission
      * go to the Azure Active Directory Graph
        * Application.ReadWrite.OwnedBy
        * User.Read
* Stand up AKS cluster
  * Cheapest single node cluster I could stand up
* populate GitLab variable with necessary data to stand-up a kubernetes Terraform provider
* add app gateway

## TODO
* install app gateway ingress controller
* setup automatic let's encrypt TLS cert updating
  * https://intelequia.com/blog/post/1012/automating-azure-application-gateway-ssl-certificate-renewals-with-let-s-encrypt-and-azure-automation
* deploy a hello-world site
* wire up ACI
* stale resume site & wedding site
  * build helm package
  * deploy to ACI
  * deploy
  * trigger pipelines when build is complete (for when I nuke the cluster entirely)
* deploy 
* deploy gitlab runner pod for faster builds
* finally get backing up to stoic meditations podcast

## Longer term
* The app registration's password expired in 2 years, automate cycling or find alternative