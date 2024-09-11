#!/bin/bash

# Set error mode
set -e

DNS_CONF_PATH="/run/dnsmasq.conf.d"
CUSTOM_CONF_NAME="local_custom_dns.conf"

CUSTOM_CONF_PATH="${DNS_CONF_PATH}/${CUSTOM_CONF_NAME}"

cat > "${CUSTOM_CONF_PATH}" <<EOF
# Created by a udm-scripts

# e.g.,
# address=/myhost.mydomain/192.168.1.100
EOF

# Restart dnsmasq so it sees the new conf file
kill -9 "$(cat /run/dnsmasq.pid)"
