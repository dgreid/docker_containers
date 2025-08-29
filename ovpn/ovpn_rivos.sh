#!/bin/bash
podman run -v ~/rivosvpn/dylan.ovpn:/dylan.ovpn -v ~/rivosvpn/credentials.txt:/credentials.txt -it --rm --cap-add=NET_ADMIN --device /dev/net/tun --name rivosvpn ovpn_run
