terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.66.3"
    }
  }
  backend "s3" {
    bucket                      = "terraform-state"
    key                         = "talk.talos.tfstate"
    region                      = "main"
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}

provider "proxmox" {
  endpoint = data.vault_generic_secret.proxmox_credentials.data["url"]
  username = data.vault_generic_secret.proxmox_credentials.data["user"]
  password = data.vault_generic_secret.proxmox_credentials.data["pass"]

  insecure = true
  ssh {
    agent = false
  }
}

provider "vault" {}