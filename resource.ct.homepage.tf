# __generated__ by OpenTofu from "Homepage.Audit"
resource "proxmox_virtual_environment_role" "homepage_audit_role" {
  provider   = proxmox.opentofu
  privileges = ["Datastore.Audit", "Mapping.Audit", "Pool.Audit", "SDN.Audit", "Sys.Audit", "VM.Audit", "VM.GuestAgent.Audit"]
  role_id    = "Homepage.Audit"
}

# __generated__ by OpenTofu from "Homepage.PowerMgmt"
resource "proxmox_virtual_environment_role" "homepage_power_management_role" {
  provider   = proxmox.opentofu
  privileges = ["Sys.PowerMgmt", "VM.PowerMgmt"]
  role_id    = "Homepage.PowerMgmt"
}

# __generated__ by OpenTofu from "Homepage"
resource "proxmox_virtual_environment_group" "homepage_group" {
  provider = proxmox.opentofu
  comment  = "Managed by OpenTofu"
  group_id = "Homepage"
  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.homepage_audit_role.role_id
  }
  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.homepage_power_management_role.role_id
  }
}

# __generated__ by OpenTofu from "homepage@pve"
resource "proxmox_virtual_environment_user" "homepage_user" {
  provider        = proxmox.opentofu
  comment         = "Managed by OpenTofu"
  email           = ""
  enabled         = true
  expiration_date = "1970-01-01T00:00:00Z"
  first_name      = ""
  groups          = [proxmox_virtual_environment_group.homepage_group.group_id]
  keys            = ""
  last_name       = ""
  password        = var.homepage_user.password
  user_id         = join("", [var.homepage_user.username, "@", var.homepage_user.realm])
}

# __generated__ by OpenTofu from "homepage@pve!homepage"
resource "proxmox_virtual_environment_user_token" "homepage_user_token" {
  provider              = proxmox.opentofu
  comment               = "Managed by OpenTofu"
  expiration_date       = null
  privileges_separation = false
  token_name            = var.homepage_user.token_name
  user_id               = join("", [var.homepage_user.username, "@", var.homepage_user.realm])
}

# __generated__ by OpenTofu from "proxmox/104"
resource "proxmox_virtual_environment_container" "homepage" {
  provider              = proxmox.opentofu
  description           = "<div align='center'>\n  <a href='https://Helper-Scripts.com' target='_blank' rel='noopener noreferrer'>\n    <img src='https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/images/logo-81x112.png' alt='Logo' style='width:81px;height:112px;'/>\n  </a>\n\n  <h2 style='font-size: 24px; margin: 20px 0;'>Homepage LXC</h2>\n\n  <p style='margin: 16px 0;'>\n    <a href='https://ko-fi.com/community_scripts' target='_blank' rel='noopener noreferrer'>\n      <img src='https://img.shields.io/badge/&#x2615;-Buy us a coffee-blue' alt='spend Coffee' />\n    </a>\n  </p>\n\n  <span style='margin: 0 10px;'>\n    <i class=\"fa fa-github fa-fw\" style=\"color: #f5f5f5;\"></i>\n    <a href='https://github.com/community-scripts/ProxmoxVE' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>GitHub</a>\n  </span>\n  <span style='margin: 0 10px;'>\n    <i class=\"fa fa-comments fa-fw\" style=\"color: #f5f5f5;\"></i>\n    <a href='https://github.com/community-scripts/ProxmoxVE/discussions' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>Discussions</a>\n  </span>\n  <span style='margin: 0 10px;'>\n    <i class=\"fa fa-exclamation-circle fa-fw\" style=\"color: #f5f5f5;\"></i>\n    <a href='https://github.com/community-scripts/ProxmoxVE/issues' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>Issues</a>\n  </span>\n</div>\n"
  environment_variables = {}
  hook_script_file_id   = null
  node_name             = var.node_1.name
  protection            = false
  start_on_boot         = true
  tags                  = ["community-script", "dashboard"]
  template              = false
  timeout_clone         = null
  timeout_create        = null
  timeout_delete        = null
  timeout_update        = null
  unprivileged          = true
  vm_id                 = null
  console {
    enabled   = true
    tty_count = 2
    type      = "tty"
  }
  cpu {
    architecture = "amd64"
    cores        = 2
    units        = 1024
  }
  disk {
    acl           = false
    datastore_id  = "local-lvm"
    mount_options = []
    quota         = false
    replicate     = false
    size          = 6
  }
  initialization {
    hostname = "homepage"
    ip_config {
      ipv4 {
        address = "dhcp"
        gateway = ""
      }
    }
    # TODO: This will cause destruction of container, so we need to have ansible
    # config and backup of the homepage config to do this
    # user_account {
    #   keys     = [var.admin_user.public_key]
    #   password = var.homepage.admin_user.password
    # }
  }
  memory {
    dedicated = 4096
    swap      = 512
  }
  network_interface {
    bridge      = "vmbr0"
    enabled     = true
    firewall    = false
    mac_address = "BC:24:11:67:74:72"
    mtu         = 0
    name        = "eth0"
    rate_limit  = 0
    vlan_id     = 0
  }
  operating_system {
    template_file_id = ""
    type             = "debian"
  }
}

# __generated__ by OpenTofu from "container/proxmox/104"
resource "proxmox_virtual_environment_firewall_options" "homepage" {
  provider      = proxmox.opentofu
  container_id  = var.homepage.ct_id
  dhcp          = null
  enabled       = null
  input_policy  = null
  ipfilter      = null
  log_level_in  = null
  log_level_out = null
  macfilter     = null
  ndp           = null
  node_name     = var.node_1.name
  output_policy = null
  radv          = null
  vm_id         = null
}

# __generated__ by OpenTofu from "container/proxmox/104"
resource "proxmox_virtual_environment_firewall_rules" "homepage" {
  provider     = proxmox.opentofu
  container_id = var.homepage.ct_id
  node_name    = var.node_1.name
  vm_id        = null
}