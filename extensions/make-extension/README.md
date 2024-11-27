# Demo 4

```sh
export TALOS_VERSION=v1.8.1
export ARCH=amd64
export IMAGE_EXT="ghcr.io/qjoly/talos.coffee.extension/app:v0.0.1"

podman run --rm -t -v /dev:/dev --privileged -v "$PWD/_out:/out" \
    "ghcr.io/siderolabs/imager:${TALOS_VERSION}" --arch "${ARCH}" \
    --system-extension-image  ${IMAGE_EXT} \
    iso

```
