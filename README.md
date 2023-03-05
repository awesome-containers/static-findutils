# Statically linked Findutils

Statically linked [Findutils] container image with [Bash]

> ~ 5,0M

```bash
ghcr.io/awesome-containers/static-findutils:latest
ghcr.io/awesome-containers/static-findutils:4.9.0

docker.io/awesomecontainers/static-findutils:latest
docker.io/awesomecontainers/static-findutils:4.9.0
```

Slim statically linked [Findutils] container image with [Bash]
packaged with [UPX]

> ~ 880K

```bash
ghcr.io/awesome-containers/static-findutils:latest-slim
ghcr.io/awesome-containers/static-findutils:4.9.0-slim

docker.io/awesomecontainers/static-findutils:latest-slim
docker.io/awesomecontainers/static-findutils:4.9.0-slim
```

[Findutils]: <https://www.gnu.org/software/findutils/>
[Bash]: https://github.com/awesome-containers/static-bash
[UPX]: https://upx.github.io/

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_FINDUTILS_IMAGE="$image" \
  --build-arg STATIC_FINDUTILS_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
