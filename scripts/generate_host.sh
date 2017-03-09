#!/bin/bash
cd /etc/ipsec.d/
mkdir -p private certs
ipsec pki --gen --type rsa --size 4096 --outform pem > private/vpnHostKey.pem
chmod 600 private/vpnHostKey.pem
ipsec pki --pub --in private/vpnHostKey.pem --type rsa | ipsec pki --issue --lifetime 3650 --cacert cacerts/strongswanCert.pem --cakey private/strongswanKey.pem --dn "C=CH, O=strongSwan, CN=${VPN_HOST}" --san ${VPN_HOST} --flag serverAuth --flag ikeIntermediate --outform pem > certs/vpnHostCert.pem
echo ": RSA vpnHostKey.pem" >> /etc/ipsec.secrets

