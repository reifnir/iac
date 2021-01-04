#!/bin/sh -e

# If TF_USERNAME is unset then default to GITLAB_USER_LOGIN
TF_USERNAME="${TF_USERNAME:-${GITLAB_USER_LOGIN}}"

# If TF_PASSWORD is unset then default to gitlab-ci-token/CI_JOB_TOKEN
if [ -z "${TF_PASSWORD}" ]; then
  TF_USERNAME="gitlab-ci-token"
  TF_PASSWORD="${CI_JOB_TOKEN}"
fi

# If TF_ADDRESS is unset but TF_STATE_NAME is provided, then default to GitLab backend in current project
if [ -n "${TF_STATE_NAME}" ]; then
  TF_ADDRESS="${TF_ADDRESS:-${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/terraform/state/${TF_STATE_NAME}}"
fi

# Set variables for the HTTP backend to default to TF_* values
export TF_HTTP_ADDRESS="${TF_HTTP_ADDRESS:-${TF_ADDRESS}}"
export TF_HTTP_LOCK_ADDRESS="${TF_HTTP_LOCK_ADDRESS:-${TF_ADDRESS}/lock}"
export TF_HTTP_LOCK_METHOD="${TF_HTTP_LOCK_METHOD:-POST}"
export TF_HTTP_UNLOCK_ADDRESS="${TF_HTTP_UNLOCK_ADDRESS:-${TF_ADDRESS}/lock}"
export TF_HTTP_UNLOCK_METHOD="${TF_HTTP_UNLOCK_METHOD:-DELETE}"
export TF_HTTP_USERNAME="${TF_HTTP_USERNAME:-${TF_USERNAME}}"
export TF_HTTP_PASSWORD="${TF_HTTP_PASSWORD:-${TF_PASSWORD}}"
export TF_HTTP_RETRY_WAIT_MIN="${TF_HTTP_RETRY_WAIT_MIN:-5}"

if [ -n "${TF_HTTP_ADDRESS}" ] && ! terraform_is_at_least 0.13.2; then
set -- \
  -backend-config=address="${TF_HTTP_ADDRESS}" \
  -backend-config=lock_address="${TF_HTTP_LOCK_ADDRESS}" \
  -backend-config=unlock_address="${TF_HTTP_UNLOCK_ADDRESS}" \
  -backend-config=username="${TF_HTTP_USERNAME}" \
  -backend-config=password="${TF_HTTP_PASSWORD}" \
  -backend-config=lock_method="${TF_HTTP_LOCK_METHOD}" \
  -backend-config=unlock_method="${TF_HTTP_UNLOCK_METHOD}" \
  -backend-config=retry_wait_min="${TF_HTTP_RETRY_WAIT_MIN}"
fi
terraform init "${@}" -reconfigure
terraform output
