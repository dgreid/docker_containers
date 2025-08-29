Used to run git commands in another network namespace that has a vpn:

```bash
podman run --rm --network container:somevpn -v something:/src git_client git fetch
```

See also the rivos git client script in ~/scripts.
