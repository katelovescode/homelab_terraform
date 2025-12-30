# __generated__ by OpenTofu from "proxmox"
resource "proxmox_virtual_environment_dns" "node_1" {
  provider  = proxmox.opentofu
  domain    = "local"
  node_name = var.node_1.name
  servers   = [var.dns.gateway]
}

# __generated__ by OpenTofu from "proxmox"
resource "proxmox_virtual_environment_hosts" "proxmox_hosts" {
  provider  = proxmox.opentofu
  node_name = var.node_1.name
  entry {
    address   = "127.0.0.1"
    hostnames = ["localhost.localdomain", "localhost"]
  }
  entry {
    address   = var.node_1.ip_address
    hostnames = [join("", [var.node_1.name, ".local"]), var.node_1.name]
  }
  entry {
    address   = "::1"
    hostnames = ["ip6-localhost", "ip6-loopback"]
  }
  entry {
    address   = "fe00::0"
    hostnames = ["ip6-localnet"]
  }
  entry {
    address   = "ff00::0"
    hostnames = ["ip6-mcastprefix"]
  }
  entry {
    address   = "ff02::1"
    hostnames = ["ip6-allnodes"]
  }
  entry {
    address   = "ff02::2"
    hostnames = ["ip6-allrouters"]
  }
  entry {
    address   = "ff02::3"
    hostnames = ["ip6-allhosts"]
  }
}

# __generated__ by OpenTofu from "proxmox,/etc/apt/sources.list.d/pve-enterprise.sources,0"
resource "proxmox_virtual_environment_apt_repository" "enterprise_repo" {
  provider  = proxmox.opentofu
  enabled   = false
  file_path = "/etc/apt/sources.list.d/pve-enterprise.sources"
  index     = 0
  node      = var.node_1.name
}

# __generated__ by OpenTofu from "proxmox,/etc/apt/sources.list.d/proxmox.sources,0"
resource "proxmox_virtual_environment_apt_repository" "no_subscription_repo" {
  provider  = proxmox.opentofu
  enabled   = true
  file_path = "/etc/apt/sources.list.d/proxmox.sources"
  index     = 0
  node      = var.node_1.name
}

# __generated__ by OpenTofu from "proxmox,/etc/apt/sources.list.d/ceph.sources,0"
resource "proxmox_virtual_environment_apt_repository" "ceph_squid_repo" {
  provider  = proxmox.opentofu
  enabled   = false
  file_path = "/etc/apt/sources.list.d/ceph.sources"
  index     = 0
  node      = var.node_1.name
}

# __generated__ by OpenTofu from "proxmox:vmbr0"
resource "proxmox_virtual_environment_network_linux_bridge" "vmbr0" {
  provider   = proxmox.opentofu
  address    = join("", [var.node_1.ip_address, "/", var.node_1.cidr])
  address6   = null
  autostart  = true
  comment    = null
  gateway    = var.dns.gateway
  gateway6   = null
  mtu        = null
  name       = "vmbr0"
  node_name  = var.node_1.name
  ports      = ["enp5s0"]
  vlan_aware = false
}

# __generated__ by OpenTofu from "proxmox"
resource "proxmox_virtual_environment_time" "node_1" {
  provider  = proxmox.opentofu
  node_name = var.node_1.name
  time_zone = "America/Chicago"
}

# __generated__ by OpenTofu from "node/proxmox"
resource "proxmox_virtual_environment_firewall_rules" "node_1" {
  provider     = proxmox.opentofu
  container_id = null
  node_name    = var.node_1.name
  vm_id        = null
}

# __generated__ by OpenTofu from "proxmox/local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
resource "proxmox_virtual_environment_file" "debian_12" {
  provider = proxmox.node_by_ip
  content_type   = "vztmpl"
  datastore_id   = var.node_1.image_datastore
  file_mode      = null
  node_name      = var.node_1.name
  overwrite      = false
  timeout_upload = null
  source_file {
    file_name = "debian-12-standard_12.2-1_amd64.tar.zst"
    path      = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
  }
}

# __generated__ by OpenTofu from "proxmox/local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
resource "proxmox_virtual_environment_file" "debian_13" {
  provider = proxmox.node_by_ip
  content_type   = "vztmpl"
  datastore_id   = var.node_1.image_datastore
  file_mode      = null
  node_name      = var.node_1.name
  overwrite      = false
  timeout_upload = null
  source_file {
    file_name = "debian-13-standard_13.1-2_amd64.tar.zst"
    path      = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.qcow2"
  }
}

# __generated__ by OpenTofu from "proxmox/local:iso/proxmox-ve_9.0-1.iso"
resource "proxmox_virtual_environment_file" "proxmox_9" {
  provider = proxmox.node_by_ip
  content_type   = "iso"
  datastore_id   = var.node_1.image_datastore
  file_mode      = null
  node_name      = var.node_1.name
  overwrite      = false
  timeout_upload = null
  source_file {
    file_name = "proxmox-ve_9.0-1.iso"
    path      = "https://enterprise.proxmox.com/iso/proxmox-ve_9.1-1.iso"
  }
}

# __generated__ by OpenTofu from "proxmox/local:iso/ubuntu-24.04.3-live-server-amd64.iso"
resource "proxmox_virtual_environment_file" "ubuntu_24_04_3_live_server_amd64" {
  provider = proxmox.node_by_ip
  content_type   = "iso"
  datastore_id   = var.node_1.image_datastore
  file_mode      = null
  node_name      = var.node_1.name
  overwrite      = false
  timeout_upload = null
  source_file {
    file_name = "ubuntu-24.04.3-live-server-amd64.iso"
    path      = "https://releases.ubuntu.com/24.04.3/ubuntu-24.04.3-live-server-amd64.iso"
  }
}