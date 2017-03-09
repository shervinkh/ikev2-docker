#!/bin/bash
cd /etc/ipsec.d/
mkdir -p private certs clients

if [ "$#" != "1" ]; then
    echo "Usage $0 client_name"
    exit 1
fi
ipsec pki --gen --type rsa --size 4096 --outform pem > private/$1Key.pem
chmod 600 private/$1Key.pem
ipsec pki --pub --in private/$1Key.pem --type rsa | ipsec pki --issue --lifetime 3650 --cacert cacerts/strongswanCert.pem --cakey private/strongswanKey.pem --dn "C=CH, O=strongSwan, CN=$1" --san $1 --outform pem > certs/$1Cert.pem
openssl pkcs12 -export -inkey private/$1Key.pem -in certs/$1Cert.pem -name "VPN client certificate" -certfile cacerts/strongswanCert.pem -caname "strongSwan Root CA" -out clients/$1.p12

