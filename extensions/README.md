# Demo 3 - Extensions

```sh
yq eval -o=json customization.yaml > customization.json
```

```sh
curl -X POST https://factory.talos.dev/schematics
  -H "Content-Type: application/json"
  -d @customization.json
```

```sh
talosctl --force --talosconfig=../talhelper/clusterconfig/talosconfig \
    upgrade --image=factory.talos.dev/installer/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515:v1.8.1 \
    -n 192.168.1.101"
```

```sh
talosctl services \
    --talosconfig ../talhelper/clusterconfig/talosconfig | grep qemu
```
