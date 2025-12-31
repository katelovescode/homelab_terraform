# __generated__ by OpenTofu
resource "proxmox_virtual_environment_vm" "nginx_proxy_manager" {
  provider                             = proxmox.root_node_by_ip
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["scsi0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = ""
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = ""
  machine                              = ""
  migrate                              = false
  name                                 = "nginx-proxy-manager"
  node_name                            = var.node_1.name
  on_boot                              = true
  protection                           = false
  purge_on_destroy                     = true
  reboot                               = false
  reboot_after_update                  = true
  scsi_hardware                        = "virtio-scsi-single"
  stop_on_destroy                      = false
  tablet_device                        = true
  tags                                 = []
  template                             = false
  timeout_clone                        = 1800
  timeout_create                       = 1800
  timeout_migrate                      = 1800
  timeout_reboot                       = 1800
  timeout_shutdown_vm                  = 1800
  timeout_start_vm                     = 1800
  timeout_stop_vm                      = 300
  vm_id                                = var.nginx_proxy_manager.vm_id
  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }
  cpu {
    affinity     = "0-1"
    architecture = ""
    cores        = 2
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "x86-64-v2-AES"
    units        = 1024
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = var.node_1.disk_datastore
    discard           = "ignore"
    file_format       = "raw"
    file_id           = ""
    import_from       = ""
    interface         = "scsi0"
    iothread          = true
    path_in_datastore = "vm-103-disk-0"
    replicate         = true
    serial            = ""
    size              = 64
    ssd               = false
  }
  disk {
    aio               = "io_uring"
    backup            = false
    cache             = "none"
    datastore_id      = var.node_1.image_datastore
    discard           = "ignore"
    file_format       = "raw"
    file_id           = ""
    import_from       = ""
    interface         = "ide2"
    iothread          = false
    path_in_datastore = join("", [proxmox_virtual_environment_file.ubuntu_24_04_3_live_server_amd64.content_type, "/", proxmox_virtual_environment_file.ubuntu_24_04_3_live_server_amd64.source_file[0].file_name])
    replicate         = true
    serial            = ""
    size              = 3
    ssd               = false
  }
  initialization {
    ip_config {
      ipv4 {
        address = var.nginx_proxy_manager.ip_address
      }
    }

    user_account {
      keys     = [var.admin_user.public_key]
      username = var.nginx_proxy_manager.admin_user.username
      password = var.nginx_proxy_manager.admin_user.password
    }
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
    firewall     = true
    mac_address  = "BC:24:11:DF:4D:13"
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
}

# __generated__ by OpenTofu from "vm/proxmox/103"
resource "proxmox_virtual_environment_firewall_options" "nginx_proxy_manager" {
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
  vm_id         = var.nginx_proxy_manager.vm_id
}

# __generated__ by OpenTofu from "vm/proxmox/103"
resource "proxmox_virtual_environment_firewall_rules" "nginx_proxy_manager" {
  provider     = proxmox.opentofu
  container_id = null
  node_name    = var.node_1.name
  vm_id        = var.nginx_proxy_manager.vm_id
}