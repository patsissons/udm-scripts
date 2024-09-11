#!/bin/bash

# Set error mode
set -e

# inspired by: https://github.com/unifi-utilities/unifios-utilities/blob/main/on-boot-script-2.x/examples/udm-files/on_boot.d/15-add-github-ssh-keys.sh

# Enter your username on github to get the public keys for
GITHUB_USER=GITHUB_USERNAME
KEYS_DIR="/root/.ssh"
KEYS_FILE="${KEYS_DIR}/authorized_keys"

GITHUB_KEYS_URL="https://github.com/${GITHUB_USER}.keys"

if curl --output /dev/null --silent --head --fail "${GITHUB_KEYS_URL}"; then
  IFS='
'
  GITHUB_KEYS=$(curl --silent "${GITHUB_KEYS_URL}") && \
  echo "Downloaded keys from Github" && \
  for SSH_KEY in ${GITHUB_KEYS}; do
    if ! grep -Fxq "${SSH_KEY}" "${KEYS_FILE}"; then
      echo "Adding ${SSH_KEY} to ${KEYS_FILE}"
      echo "${SSH_KEY}" >> "${KEYS_FILE}"
    fi
  done
else
  echo "Could not download ${GITHUB_USER}'s key file from github (${GITHUB_KEYS_URL})"
fi
