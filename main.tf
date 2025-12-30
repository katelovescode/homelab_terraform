terraform {
  required_version = ">= 1.0"
  required_providers {
    proxmox = {
      source                = "bpg/proxmox"
      version               = "0.89.0"
      configuration_aliases = [proxmox.opentofu]
    }
  }
}

# ROOT USER ACTIONS

provider "proxmox" {
  endpoint = var.cluster.endpoint
  insecure = false
  username = var.root_user.username
  password = var.root_user.password
}

# OpenTofu USER ACTIONS

provider "proxmox" {
  alias     = "opentofu"
  endpoint  = var.cluster.endpoint
  insecure  = false
  api_token = var.opentofu_user.api_token
}