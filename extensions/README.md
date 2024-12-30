# Demo 3 - Extensions

**Génération et conversion de notre patch:**

```sh
yq eval -o=json customization.yaml > customization.json
cat customization.json
```

**Envoi du patch à l'API:**

```sh {"terminalRows":"2"}
curl -s -X POST https://factory.talos.dev/schematics \
  -H "Content-Type: application/json" \
  -d @customization.json | jq -r .id
```

**Mise à jour d'un noeud existant avec l'image de notre patch:**

```sh
id=$__
echo "Use the following ID : $id"
talosctl --force --talosconfig=../talhelper/clusterconfig/talosconfig \
    upgrade --image=factory.talos.dev/installer/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515:v1.8.1 \
    -n 192.168.1.114
```

**Vérifier que le patch a été appliqué correctement:**

```sh
talosctl services \
    --talosconfig ../talhelper/clusterconfig/talosconfig -n 192.168.1.114
```
