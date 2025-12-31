# __generated__ by OpenTofu from "HomeAssistant.Audit"
resource "proxmox_virtual_environment_role" "homeassistant_audit_role" {
  provider   = proxmox.opentofu
  privileges = ["Datastore.Audit", "Sys.Audit", "VM.Audit"]
  role_id    = "HomeAssistant.Audit"
}

# __generated__ by OpenTofu from "HomeAssistant.Update"
resource "proxmox_virtual_environment_role" "homeassistant_update_role" {
  provider   = proxmox.opentofu
  privileges = ["Sys.Modify"]
  role_id    = "HomeAssistant.Update"
}

# __generated__ by OpenTofu from "HomeAssistant.NodePowerMgmt"
resource "proxmox_virtual_environment_role" "homeassistant_node_power_management_role" {
  provider   = proxmox.opentofu
  privileges = ["Sys.PowerMgmt"]
  role_id    = "HomeAssistant.NodePowerMgmt"
}

# __generated__ by OpenTofu from "HomeAssistant.VMPowerMgmt"
resource "proxmox_virtual_environment_role" "homeassistant_vm_power_management_role" {
  provider   = proxmox.opentofu
  privileges = ["VM.PowerMgmt"]
  role_id    = "HomeAssistant.VMPowerMgmt"
}

# __generated__ by OpenTofu from "HomeAssistant"
resource "proxmox_virtual_environment_group" "homeassistant_group" {
  provider = proxmox.opentofu
  comment  = "Managed by OpenTofu"
  group_id = "HomeAssistant"
  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.homeassistant_audit_role.role_id
  }
  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.homeassistant_node_power_management_role.role_id
  }
  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.homeassistant_update_role.role_id
  }
  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.homeassistant_vm_power_management_role.role_id
  }
}

# __generated__ by OpenTofu from "homeassistant@pve"
resource "proxmox_virtual_environment_user" "homeassistant_user" {
  provider        = proxmox.opentofu
  comment         = "Managed by OpenTofu"
  email           = ""
  enabled         = true
  expiration_date = "1970-01-01T00:00:00Z"
  first_name      = ""
  groups          = [proxmox_virtual_environment_group.homeassistant_group.group_id]
  keys            = ""
  last_name       = ""
  password        = var.homeassistant_user.password
  user_id         = join("", [var.homeassistant_user.username, "@", var.homeassistant_user.realm])
}

# __generated__ by OpenTofu from "homeassistant@pve!homeassistant"
resource "proxmox_virtual_environment_user_token" "homeassistant_user_token" {
  provider              = proxmox.opentofu
  comment               = "Managed by OpenTofu"
  expiration_date       = null
  privileges_separation = false
  token_name            = var.homeassistant_user.token_name
  user_id               = join("", [var.homeassistant_user.username, "@", var.homeassistant_user.realm])
}

# __generated__ by OpenTofu
resource "proxmox_virtual_environment_vm" "homeassistant" {
  provider                             = proxmox
  acpi                                 = true
  bios                                 = "ovmf"
  boot_order                           = ["scsi0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = "<div align='center'>\n  <a href='https://Helper-Scripts.com' target='_blank' rel='noopener noreferrer'>\n    <img src='https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/images/logo-81x112.png' alt='Logo' style='width:81px;height:112px;'/>\n  </a>\n\n  <h2 style='font-size: 24px; margin: 20px 0;'>Homeassistant OS VM</h2>\n\n  <p style='margin: 16px 0;'>\n    <a href='https://ko-fi.com/community_scripts' target='_blank' rel='noopener noreferrer'>\n      <img src='https://img.shields.io/badge/&#x2615;-Buy us a coffee-blue' alt='spend Coffee' />\n    </a>\n  </p>\n\n  <span style='margin: 0 10px;'>\n    <i class=\"fa fa-github fa-fw\" style=\"color: #f5f5f5;\"></i>\n    <a href='https://github.com/community-scripts/ProxmoxVE' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>GitHub</a>\n  </span>\n  <span style='margin: 0 10px;'>\n    <i class=\"fa fa-comments fa-fw\" style=\"color: #f5f5f5;\"></i>\n    <a href='https://github.com/community-scripts/ProxmoxVE/discussions' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>Discussions</a>\n  </span>\n  <span style='margin: 0 10px;'>\n    <i class=\"fa fa-exclamation-circle fa-fw\" style=\"color: #f5f5f5;\"></i>\n    <a href='https://github.com/community-scripts/ProxmoxVE/issues' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>Issues</a>\n  </span>\n</div>"
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = ""
  machine                              = "q35"
  migrate                              = false
  name                                 = "homeassistant"
  node_name                            = var.node_1.name
  on_boot                              = true
  protection                           = false
  purge_on_destroy                     = true
  reboot                               = false
  reboot_after_update                  = true
  scsi_hardware                        = "virtio-scsi-pci"
  started                              = true
  stop_on_destroy                      = false
  tablet_device                        = false
  tags                                 = ["community-script"]
  template                             = false
  timeout_clone                        = 1800
  timeout_create                       = 1800
  timeout_migrate                      = 1800
  timeout_reboot                       = 1800
  timeout_shutdown_vm                  = 1800
  timeout_start_vm                     = 1800
  timeout_stop_vm                      = 300
  vm_id                                = var.homeassistant.vm_id
  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }
  cpu {
    architecture = ""
    cores        = 2
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "qemu64"
    units        = 1024
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = var.node_1.disk_datastore
    discard           = "on"
    file_format       = "raw"
    file_id           = ""
    import_from       = ""
    interface         = "scsi0"
    iothread          = false
    path_in_datastore = "vm-102-disk-1"
    replicate         = true
    serial            = ""
    size              = 32
    ssd               = true
  }
  initialization {
    ip_config {
      ipv4 {
        address = join("", [var.homeassistant.ip_address, "/", var.homeassistant.ip_cidr])
        gateway = var.dns.gateway
      }
    }

    user_account {
      keys     = [var.admin_user.public_key]
      username = var.homeassistant.admin_user.username
    }
  }
  efi_disk {
    datastore_id      = var.node_1.disk_datastore
    file_format       = "raw"
    pre_enrolled_keys = false
    type              = "4m"
  }
  memory {
    dedicated = 4096
    floating  = 0
    shared    = 0
  }
  network_device {
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "02:0F:DA:89:13:57"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 0
  }
  operating_system {
    type = "l26"
  }
  serial_device {
    device = "socket"
  }
}

# __generated__ by OpenTofu from "vm/proxmox/102"
resource "proxmox_virtual_environment_firewall_options" "homeassistant" {
  provider      = proxmox.opentofu
  container_id  = null
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
  vm_id         = var.homeassistant.vm_id
}

# __generated__ by OpenTofu from "vm/proxmox/102"
resource "proxmox_virtual_environment_firewall_rules" "homeassistant" {
  provider     = proxmox.opentofu
  container_id = null
  node_name    = var.node_1.name
  vm_id        = var.homeassistant.vm_id
}