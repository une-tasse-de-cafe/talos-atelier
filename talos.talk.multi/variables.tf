variable "network_device" {
  default     = "vmbr2"
  description = "The network device to use for the VM"
}

variable "disk_datastore_id" {
  default     = "local-lvm"
  description = "The datastore to use for the VM"
}

variable "cluster_node" {
  default     = "homelab-proxmox-01"
  description = "The cluster node to use for the VM"
}

variable "instance_cores" {
  default     = 2
  description = "The number of cpu cores to use"
}

variable "instance_memory" {
  default     = 3072
  description = "The number of cpu cores to use"
}

variable "iso_image" {
  default     = "local:iso/home-omni-v1.8.1.iso"
  description = "The iso image to use for the VM"
}

variable "pool_id" {
  default     = "Omni"
  description = "The pool id to use for the VM"
}

variable "tags" {
  default     = ["talos", "talk"]
  description = "The tags to use for the VM"
}