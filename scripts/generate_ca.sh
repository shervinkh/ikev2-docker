#!/bin/bash
cd /etc/ipsec.d/
mkdir -p private cacerts
ipsec pki --gen --type rsa --size 4096 --outform pem > private/strongswanKey.pem
chmod 600 private/strongswanKey.pem
ipsec pki --self --ca --lifetime 3650 --in private/strongswanKey.pem --type rsa --dn "C=CH, O=strongSwan, CN=strongSwan Root CA" --outform pem > cacerts/strongswanCert.pem

