#!/bin/bash

# Set error mode
set -e

# Load environment variables
set -a
source /data/udm-scripts/udm-scripts.env
set +a

SERVICES=${1:-boot daily hourly}

echo "Installing udm-scripts systemd services and timers [${SERVICES}]"
for SERVICE in ${SERVICES}; do
  echo "Installing udm-scripts-${SERVICE}"
  cp -f "${UDM_SCRIPTS_PATH}/resources/systemd/udm-scripts-${SERVICE}.service" "/etc/systemd/system/"
  cp -f "${UDM_SCRIPTS_PATH}/resources/systemd/udm-scripts-${SERVICE}.timer" "/etc/systemd/system/"
done
systemctl daemon-reload
for SERVICE in ${SERVICES}; do
  systemctl enable "udm-scripts-${SERVICE}.timer"
  systemctl start "udm-scripts-${SERVICE}.timer"
done
