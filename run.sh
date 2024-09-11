#!/bin/bash

# Set error mode
set -e

ENV_FILE_PATH="$(dirname ${BASH_SOURCE[0]})/udm-scripts.env"
if [ ! -r "${ENV_FILE_PATH}" ]; then
  echo "Environment file not found: ${ENV_FILE_PATH}"
  exit 1
fi

# Load environment variables
set -a
source ${ENV_FILE_PATH}
set +a

SCRIPT_TYPE=$1
if [ -z "${SCRIPT_TYPE}" ]; then
  echo "Usage: $0 <boot|daily|hourly>"
  exit 1
fi

SCRIPT_RUN_PATH="${UDM_SCRIPTS_PATH}/resources/scripts/${SCRIPT_TYPE}"
if [ ! -d "${SCRIPT_RUN_PATH}" ]; then
  echo "Invalid script run path: ${SCRIPT_RUN_PATH}"
  exit 1
fi

for SCRIPT_PATH in $(find -L "${SCRIPT_RUN_PATH}" -mindepth 1 -maxdepth 1 -type f | sort); do
  case "${SCRIPT_PATH}" in
    *.keep);;
    *.sh)
      if test -x "${SCRIPT_PATH}"; then
        echo "Running $SCRIPT_PATH"
        "${SCRIPT_PATH}"
      else
        echo "Sourcing ${SCRIPT_PATH}";
        source "${SCRIPT_PATH}"
      fi
      ;;
    *)
      if test -x "${SCRIPT_PATH}"; then
        echo "Running $SCRIPT_PATH"
        "${SCRIPT_PATH}"
      else
        echo "ignoring ${SCRIPT_PATH}";
      fi
      ;;
  esac
done
