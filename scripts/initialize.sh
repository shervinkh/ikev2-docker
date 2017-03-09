#!/bin/bash

mkdir -p /var/log/supervisor

if [ ! ${IPV4_RANGE} ]; then export IPV4_RANGE=10.42.0.0/24; fi
if [ ! ${IPV6_RANGE} ]; then export IPV6_RANGE=172:0:0:1000::/64; fi

iptables -t nat -C POSTROUTING -s ${IPV4_RANGE} -o eth0 -j MASQUERADE || iptables -t nat -A POSTROUTING -s ${IPV4_RANGE} -o eth0 -j MASQUERADE
sed -i "s!IPV4_CLIENT_RANGE!${IPV4_RANGE}!" /etc/ipsec.conf

ip6tables -t nat -C POSTROUTING -s ${IPV6_RANGE} -o eth0 -j MASQUERADE || ip6tables -t nat -A POSTROUTING -s ${IPV6_RANGE} -o eth0 -j MASQUERADE
sed -i "s!IPV6_CLIENT_RANGE!${IPV6_RANGE}!" /etc/ipsec.conf

if [ ! ${VPN_HOST} ]; then export VPN_HOST=example.com; fi
[ -e /etc/ipsec.d/private/strongswanKey.pem ] || /scripts/generate_ca.sh
[ -e /etc/ipsec.d/private/vpnHostKey.pem ] || /scripts/generate_host.sh

echo "Initialized!"

