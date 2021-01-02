#!/bin/bash
SP_OBJECT_ID="$1"
echo "Waiting for to 60 seconds for service principal with object id of '$SP_OBJECT_ID' 'Contributor' permissions to propagate..."

RETRIES=20
while [[ $RETRIES -ge 0 ]];do
  echo "  Checking role assignment..."
  EXISTS="$(az role assignment list --subscription 58178b20-a04e-476f-90d7-1611a3025a3b | jq ".[] | select(.principalId == \"$SP_OBJECT_ID\" and .roleDefinitionName == \"Contributor\") | .")"

  if [[ ! -z $EXISTS ]];then
    echo "  Role assignment exists. Moving on."
    break
  fi
  ((RETRIES--))
  sleep 3
done
