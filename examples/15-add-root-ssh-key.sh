#!/bin/bash

# Set error mode
set -e

# inspired by: https://github.com/unifi-utilities/unifios-utilities/blob/main/on-boot-script-2.x/examples/udm-files/on_boot.d/15-add-root-ssh-keys.sh

# public key
MY_SSH_KEY="ecdsa-sha2-nistp521 ..."
KEYS_DIR="/root/.ssh"
KEYS_FILE="${KEYS_DIR}/authorized_keys"

# insert public key in KEYS_FILE if not present
if ! grep -Fxq "${MY_SSH_KEY}" "${KEYS_FILE}"; then
  echo "${MY_SSH_KEY}" >> "${KEYS_FILE}"
fi
