# IPSec IKEv2 Docker
An IKEv2 Docker
- Run with `docker run -dt --name ikev2 --cap-add NET_ADMIN --sysctl net.ipv4.ip_forward=1 --sysctl net.ipv6.conf.all.forwarding=1 --sysctl net.ipv4.conf.all.accept_redirects=0 --sysctl net.ipv4.conf.all.send_redirects=0 --sysctl net.ipv4.conf.default.accept_redirects=0 --sysctl net.ipv4.conf.default.send_redirects=0 -e VPN_HOST=example.com -e IPV4_RANGE=10.20.0.0/24 -e IPV6_RANGE=172:0:0:1000::/64 -p 500:500/udp -p 4500:4500/udp -v /home/user/ikev2/keys/:/etc/ipsec.d/ -v /home/user/ikev2/secrets/ipsec.secrets:/etc/ipsec.secrets shervinkh/ikev2`
- Then supervisor interface is at port `9001`.

