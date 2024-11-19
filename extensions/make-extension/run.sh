
TALOS_VERSION=v1.8.1
ARCH=amd64
IMAGE_EXT="ghcr.io/qjoly/talos.coffee.extension/app:v0.0.1"

if [ -z "$1" ]; then
    echo "Usage: $0 [iso|installer]"
    exit 1
else
    PROFILE=$1
fi

mkdir -p _out
podman run --rm -t -v /dev:/dev --privileged -v "$PWD/_out:/out" \
    "ghcr.io/siderolabs/imager:${TALOS_VERSION}" --arch "${ARCH}" \
    --system-extension-image  ${IMAGE_EXT} \
    "${PROFILE}"

if [ $PROFILE == "installer" ]; then
   podman load -i ./_out/installer-${ARCH}.tar
   podman tag ghcr.io/siderolabs/installer:${TALOS_VERSION} ghcr.io/qjoly/talos.coffee.extension/installer 
   podman push ghcr.io/qjoly/talos.coffee.extension/installer:${TALOS_VERSION}
fi

