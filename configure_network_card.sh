#!/bin/bash

# create a systemD script to set this every time the system boots up.
sudo tee /lib/systemd/system/ethtool.service <<EOF
[Unit]
Description=Ethtool Configration for Network Interface
[Service]
Requires=network.target
Type=oneshot
ExecStart=/sbin/ethtool -K eth0 gro off
ExecStart=/sbin/ethtool -K eth0 lro off
[Install]
WantedBy=multi-user.target
EOF

# Once the file is created, enable and start the service:
sudo systemctl enable ethtool
sudo service ethtool start
