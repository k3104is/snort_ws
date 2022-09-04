#!/bin/bash

# create some folders and files that Snort reqiures for rules:
sudo mkdir /usr/local/etc/rules
sudo mkdir /usr/local/etc/so_rules/
sudo mkdir /usr/local/etc/lists/
sudo touch /usr/local/etc/rules/local.rules
sudo touch /usr/local/etc/lists/default.blocklist
sudo mkdir /var/log/snort

# create one rule in the local.rules file
sudo tee /usr/local/etc/rules/local.rules <<EOF
alert icmp any any -> any any ( msg:"ICMP Traffic Detected"; sid:10000001; metadata:policy security-ips alert; )
EOF

# make sure it loads these rules correctly
snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules

#  run Snort in detection mode on an interface (change eth0 below to match your interface name)
sudo snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules \
-i eth0 -A alert_fast -s 65535 -k none

# Flag Description
# -c /usr/local/etc/snort/snort.lua The snort.lua configuration file.
# -R /usr/local/etc/rules/local.rules The path to the rules file containing our one ICMP rule.
# -i eth0 The interface to listen on.
# -A alert_fast Use the alert_fast output plugin to write alerts to the console.
# -s 65535 Set the snaplen so Snort doesn’t truncate and drop oversized packets.
# -k none Ignore bad checksums, otherwise snort will drop packets with bad checksum
