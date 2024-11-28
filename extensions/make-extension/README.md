# Demo 4
**Définir nos paramètres:**

```sh {"background":"true","terminalRows":"2"}
export TALOS_VERSION="v1.8.1"
export ARCH="amd64"
export IMAGE_EXT="ghcr.io/qjoly/talos.coffee.extension/app:v0.0.1"
```

**Générer une iso:**

```sh {"promptEnv":"never","terminalRows":"23"}
export TALOS_VERSION="v1.8.1"
export ARCH="amd64"
export IMAGE_EXT="ghcr.io/qjoly/talos.coffee.extension/app:v0.0.1"

podman run --rm -t -v /dev:/dev --privileged -v "$PWD/_out:/out" \
    "ghcr.io/siderolabs/imager:${TALOS_VERSION}" --arch "${ARCH}" \
    --system-extension-image  ${IMAGE_EXT} \
    iso


```

**Génération d'une image d'installation**:

```sh {"terminalRows":"25"}
podman run --rm -t -v /dev:/dev --privileged -v "$PWD/_out:/out" \
    "ghcr.io/siderolabs/imager:${TALOS_VERSION}" --arch "${ARCH}" \
    --system-extension-image  ${IMAGE_EXT} \
    installer 
```

```sh {"terminalRows":"2"}
podman load -i ./_out/installer-${ARCH}.tar
podman tag ghcr.io/siderolabs/installer:${TALOS_VERSION} ghcr.io/qjoly/talos.coffee.extension/installer:${TALOS_VERSION}
```

**Pusher l'image sur une registry:**

```sh
podman push ghcr.io/qjoly/talos.coffee.extension/installer:${TALOS_VERSION}
```
