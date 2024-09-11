# UDM scripts for Ubiquiti UniFi OS

## Overview

This should work on UniFi devices running UniFi OS 2.x or later, including:

* UniFi Dream Machine
* UniFi Dream Machine Pro
* UniFi Dream Machine SE
* UniFi Dream Router
* UniFi Dream Wall
* UniFi Express
* UniFi Network Video Recorder
* UniFi Network Video Recorder Professional

This service is designed to run scripts on **boot**, **hourly**, and **daily** cadences.

## Installation

1. clone or copy the contents of the repo to your device at `/data/udm-scripts`
    - `git clone https://github.com/patsissons/udm-scripts.git`
    - `scp -r udm-scripts root@MyRouterIP:/data/.`
2. ssh into your device
3. `cd /data/udm-scripts`
4. edit `udm-scripts.env` if necessary (should not be necessary for most users)
5. run `install.sh`

## Usage

Add your scripts to the appropriate `boot`, `daily`, and `hourly` directories in `/data/udm-scripts/resources/scripts`. Scripts are run in lexicographical order.

### Restating after changes to scripts

After making changes to the scripts, you can restart the services to apply the changes (or you can just wait for the next run for the periodic services).

- `systemctl restart udm-scripts-boot`

You can also just run the script manually from its `resources/scripts/...` path for a one-off run.

## Montioring

You can monitor the scripts using `journalctl`. You can watch a single service, or all three at the same time. e.g.,

- `journalctl -u udm-scripts-boot -f`
- `journalctl -u udm-scripts-boot -u udm-scripts-daily -u udm-scripts-hourly -f`

## Uninstallation

```bash
# Disable udm-scripts from running at boot
systemctl disable udm-scripts-boot udm-scripts-daily udm-scripts-hourly

# Delete any udm-scripts related data
rm -rf /data/udm-scripts /mnt/data/udm-scripts
rm -f /etc/systemd/system/udm-scripts-*

systemctl restart unifi-core
```

## Attribution

Thanks to [udm-le](https://github.com/kchristensen/udm-le) and [on-boot-script](https://github.com/unifi-utilities/unifios-utilities/tree/main/on-boot-script-2.x) for the inspiration and examples.
