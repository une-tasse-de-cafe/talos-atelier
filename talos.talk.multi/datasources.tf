data "vault_generic_secret" "proxmox_credentials" {
  path = "kv/hypervisors/home"
}