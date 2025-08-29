#!/bin/bash
podman run -v ~/rivosvpn/dylan.ovpn:/dylan.ovpn -v ~/rivosvpn/credentials.txt:/credentials.txt -it --rm --cap-add=NET_ADMIN --device /dev/net/tun --name rivosvpn ovpn_run
sleep 10
podman exec -it rivosvpn /bin/bash -c "echo nameserver 192.168.110.10 > /etc/resolv.conf"
