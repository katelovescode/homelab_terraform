# __generated__ by OpenTofu from "letsencrypt"
resource "proxmox_virtual_environment_acme_account" "letsencrypt" {
  provider     = proxmox
  contact      = ""
  directory    = "https://acme-v02.api.letsencrypt.org/directory"
  eab_hmac_key = null
  eab_kid      = null
  name         = "letsencrypt"
  tos          = "https://letsencrypt.org/documents/LE-SA-v1.5-February-24-2025.pdf"
}

# __generated__ by OpenTofu from "letsencrypt"
resource "proxmox_virtual_environment_acme_dns_plugin" "letsencrypt" {
  provider = proxmox
  api      = "cf"
  data = {
    CF_Token = var.letsencrypt.cf_token
  }
  digest           = var.letsencrypt.digest
  disable          = null
  plugin           = "letsencrypt"
  validation_delay = 0
}

# __generated__ by OpenTofu from "default"
resource "proxmox_virtual_environment_cluster_firewall" "default" {
  provider       = proxmox.opentofu
  ebtables       = null
  enabled        = null
  forward_policy = "ACCEPT"
  input_policy   = "DROP"
  output_policy  = "ACCEPT"
}

# __generated__ by OpenTofu from "Datacenter"
resource "proxmox_virtual_environment_cluster_options" "default" {
  provider                  = proxmox.opentofu
  bandwidth_limit_clone     = null
  bandwidth_limit_default   = null
  bandwidth_limit_migration = null
  bandwidth_limit_move      = null
  bandwidth_limit_restore   = null
  console                   = null
  crs_ha                    = null
  crs_ha_rebalance_on_start = null
  description               = null
  email_from                = null
  ha_shutdown_policy        = null
  http_proxy                = null
  keyboard                  = "en-us"
  language                  = null
  mac_prefix                = "BC:24:11"
  max_workers               = null
  migration_cidr            = null
  migration_type            = null
  next_id                   = null
  notify                    = null
}

# __generated__ by OpenTofu from "cluster"
resource "proxmox_virtual_environment_firewall_rules" "cluster" {
  provider     = proxmox.opentofu
  container_id = null
  node_name    = null
  vm_id        = null
}
