# __generated__ by OpenTofu from "proxmox/101"
resource "proxmox_virtual_environment_container" "pihole" {
  provider              = proxmox.opentofu
  description           = ""
  environment_variables = {}
  hook_script_file_id   = null
  node_name             = var.node_1.name
  protection            = false
  start_on_boot         = true
  tags                  = []
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
    size          = 20
  }
  initialization {
    hostname = "pihole"
    ip_config {
      ipv4 {
        address = "dhcp"
        gateway = ""
      }
      ipv6 {
        address = "dhcp"
        gateway = ""
      }
    }
    # TODO: This will cause destruction of container, so we need to have ansible
    # config and backup of the pihole config to do this
    # user_account {
    #   keys     = [var.admin_user.public_key]
    #   password = var.pihole.admin_user.password
    # }
  }
  memory {
    dedicated = 2048
    swap      = 512
  }
  network_interface {
    bridge      = "vmbr0"
    enabled     = true
    firewall    = true
    mac_address = "BC:24:11:10:08:69"
    mtu         = 0
    name        = "eth0"
    rate_limit  = 0
    vlan_id     = 0
  }
  operating_system {
    template_file_id = ""
    # TODO: This will cause destruction of container, so we need to have ansible
    # config and backup of the pihole config to do this
    # template_file_id = join("", [var.node_1.image_datastore, ":", proxmox_virtual_environment_file.debian_13.content_type, "/", proxmox_virtual_environment_file.debian_13.source_file[0].file_name])
    type = "debian"
  }
}

# __generated__ by OpenTofu from "container/proxmox/101"
resource "proxmox_virtual_environment_firewall_options" "pihole" {
  provider      = proxmox.opentofu
  container_id  = var.pihole.ct_id
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

# __generated__ by OpenTofu from "container/proxmox/101"
resource "proxmox_virtual_environment_firewall_rules" "pihole" {
  provider     = proxmox.opentofu
  container_id = var.pihole.ct_id
  node_name    = var.node_1.name
  vm_id        = null
}