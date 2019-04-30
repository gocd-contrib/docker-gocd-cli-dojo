#!/bin/bash -e

if [ -n "${GOCDCLI_SKIP_AUTH}" ]; then
  echo "Skipping authentication setup because GOCDCLI_SERVER_URL is set"
  exit 0
fi

if [ -z "${GOCDCLI_AUTH_TYPE}" ]; then
  if [ -n "${GOCDCLI_AUTH_TOKEN}" ]; then
    GOCDCLI_AUTH_TYPE="token"
  elif [ -n "${GOCDCLI_AUTH_USER}" ]; then
    GOCDCLI_AUTH_TYPE="basic"
  else
    if [ -f "${dojo_identity}/.gocd/settings.yaml" ]; then
      echo "Using gocd-cli settings from docker host"
      mkdir -p "${dojo_home}/.gocd"
      cp "${dojo_identity}/.gocd/settings.yaml" "${dojo_home}/.gocd"
      exit 0
    else
      echo "You must provide environment variables or settings file to authenticate with GoCD server"
      exit 5
    fi
  fi
fi

if [ -z "${GOCDCLI_SERVER_URL}" ]; then
  echo "GOCDCLI_SERVER_URL cannot be empty"
  exit 5
fi
gocd config server-url ${GOCDCLI_SERVER_URL}
if [ "${GOCDCLI_AUTH_TYPE}" == "basic" ]; then
  gocd config auth-basic "${GOCDCLI_AUTH_USER}" "${GOCDCLI_AUTH_PASSWORD}"
else
  gocd config auth-token "${GOCDCLI_AUTH_TOKEN}"
fi
