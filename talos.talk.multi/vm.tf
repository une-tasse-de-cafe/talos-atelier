resource "proxmox_virtual_environment_vm" "talos_vm" {
  name = "talos-vm-${count.index}"
  tags  = var.tags

  count = 4
  node_name = var.cluster_node

  agent {
    enabled = true
  }

  stop_on_destroy = true

  pool_id = var.pool_id

  disk {
    datastore_id = var.disk_datastore_id
    file_format  = "raw"
    interface    = "scsi0"
    size         = 32
  }

  cdrom {
    enabled = true
    file_id = var.iso_image
  }

  cpu {
    cores = var.instance_cores
    type  = "host"

  }

  memory {
    dedicated = var.instance_memory
    floating  = var.instance_memory
  }

  network_device {
    bridge = var.network_device
  }

}