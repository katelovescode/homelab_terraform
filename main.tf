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

resource "proxmox_virtual_environment_user" "root_user" {
  comment  = "Managed by OpenTofu"
  user_id  = var.root_user.username
  email    = var.admin_user.email
  password = var.root_user.password
}

# __generated__ by OpenTofu from "letsencrypt"
resource "proxmox_virtual_environment_acme_account" "letsencrypt" {
  contact      = ""
  directory    = "https://acme-v02.api.letsencrypt.org/directory"
  eab_hmac_key = null
  eab_kid      = null
  name         = "letsencrypt"
  tos          = "https://letsencrypt.org/documents/LE-SA-v1.5-February-24-2025.pdf"
}

# __generated__ by OpenTofu from "letsencrypt"
resource "proxmox_virtual_environment_acme_dns_plugin" "letsencrypt" {
  api = "cf"
  data = {
    CF_Token = var.letsencrypt.cf_token
  }
  digest           = var.letsencrypt.digest
  disable          = null
  plugin           = "letsencrypt"
  validation_delay = 0
}

# __generated__ by OpenTofu from "OpenTofu"
resource "proxmox_virtual_environment_role" "opentofu_role" {
  privileges = [
    "Datastore.Allocate",
    "Datastore.AllocateTemplate",
    "Datastore.Audit",
    "Group.Allocate",
    "Mapping.Audit",
    "Permissions.Modify",
    "Pool.Audit",
    "SDN.Audit",
    "Sys.Audit",
    "Sys.Modify",
    "User.Modify",
    "VM.Audit",
    "VM.Config.CDROM",
    "VM.Config.Cloudinit",
    "VM.Config.CPU",
    "VM.Config.Disk",
    "VM.Config.HWType",
    "VM.Config.Memory",
    "VM.Config.Network",
    "VM.Config.Options",
    "VM.GuestAgent.Audit",
    "VM.PowerMgmt"
  ]
  role_id = "OpenTofu"
}

# __generated__ by OpenTofu from "OpenTofu"
resource "proxmox_virtual_environment_group" "opentofu_group" {
  comment  = "Managed by OpenTofu"
  group_id = "OpenTofu"
  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.opentofu_role.role_id
  }
}

# __generated__ by OpenTofu from "opentofu@pve"
resource "proxmox_virtual_environment_user" "opentofu_user" {
  comment         = "Managed by OpenTofu"
  email           = ""
  enabled         = true
  expiration_date = "1970-01-01T00:00:00Z"
  first_name      = ""
  groups          = [proxmox_virtual_environment_group.opentofu_group.group_id]
  keys            = ""
  last_name       = ""
  password        = var.opentofu_user.password
  user_id         = join("", [var.opentofu_user.username, "@", var.opentofu_user.realm])
}

# __generated__ by OpenTofu from "opentofu@pve!opentofu"
resource "proxmox_virtual_environment_user_token" "opentofu_user_token" {
  comment               = "Managed by OpenTofu"
  expiration_date       = null
  privileges_separation = false
  token_name            = var.opentofu_user.token_name
  user_id               = join("", [var.opentofu_user.username, "@", var.opentofu_user.realm])
}

# OpenTofu USER ACTIONS

provider "proxmox" {
  alias     = "opentofu"
  endpoint  = var.cluster.endpoint
  insecure  = false
  api_token = var.opentofu_user.api_token
}

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

# __generated__ by OpenTofu from "kate@pam"
resource "proxmox_virtual_environment_user" "kate_user" {
  provider        = proxmox.opentofu
  comment         = "Managed by OpenTofu"
  email           = var.admin_user.email
  enabled         = true
  expiration_date = "1970-01-01T00:00:00Z"
  first_name      = var.admin_user.first_name
  groups          = []
  keys            = "x"
  last_name       = var.admin_user.last_name
  password        = var.admin_user.password
  user_id         = join("", [var.admin_user.username, "@", var.admin_user.realm])
  acl {
    path      = "/"
    propagate = true
    role_id   = "Administrator"
  }
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

# __generated__ by OpenTofu from "homeassistant@pve!homeassistant"
resource "proxmox_virtual_environment_user_token" "homeassistant_user_token" {
  provider              = proxmox.opentofu
  comment               = "Managed by OpenTofu"
  expiration_date       = null
  privileges_separation = false
  token_name            = var.homeassistant_user.token_name
  user_id               = join("", [var.homeassistant_user.username, "@", var.homeassistant_user.realm])
}

# __generated__ by OpenTofu from "proxmox"
resource "proxmox_virtual_environment_dns" "node_1" {
  provider  = proxmox.opentofu
  domain    = "local"
  node_name = var.node_1.name
  servers   = [var.dns.gateway]
}

moved {
  from = proxmox_virtual_environment_dns.proxmox_dns
  to   = proxmox_virtual_environment_dns.node_1
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

# __generated__ by OpenTofu from "proxmox,/etc/apt/sources.list.d/pve-enterprise.sources,0"
resource "proxmox_virtual_environment_apt_repository" "enterprise_repo" {
  provider  = proxmox.opentofu
  enabled   = false
  file_path = "/etc/apt/sources.list.d/pve-enterprise.sources"
  index     = 0
  node      = var.node_1.name
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

# __generated__ by OpenTofu from "vm/proxmox/999"
resource "proxmox_virtual_environment_firewall_rules" "ubuntu_server_2024_template" {
  provider     = proxmox.opentofu
  container_id = null
  node_name    = var.node_1.name
  vm_id        = var.ubuntu_server_2024_template.vm_id
}

# __generated__ by OpenTofu from "vm/proxmox/101"
resource "proxmox_virtual_environment_firewall_rules" "bookstack" {
  provider     = proxmox.opentofu
  container_id = null
  node_name    = var.node_1.name
  vm_id        = var.bookstack.vm_id
}

# __generated__ by OpenTofu from "vm/proxmox/103"
resource "proxmox_virtual_environment_firewall_rules" "nginx_proxy_manager" {
  provider     = proxmox.opentofu
  container_id = null
  node_name    = var.node_1.name
  vm_id        = var.nginx_proxy_manager.vm_id
}

# __generated__ by OpenTofu from "container/proxmox/104"
resource "proxmox_virtual_environment_firewall_rules" "homepage" {
  provider     = proxmox.opentofu
  container_id = var.homepage.ct_id
  node_name    = var.node_1.name
  vm_id        = null
}

# __generated__ by OpenTofu from "vm/proxmox/101"
resource "proxmox_virtual_environment_firewall_options" "bookstack" {
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
  vm_id         = var.bookstack.vm_id
}

# __generated__ by OpenTofu from "vm/proxmox/105"
resource "proxmox_virtual_environment_firewall_rules" "gitlab" {
  provider     = proxmox.opentofu
  container_id = null
  node_name    = var.node_1.name
  vm_id        = var.gitlab.vm_id
}

# __generated__ by OpenTofu from "vm/proxmox/105"
resource "proxmox_virtual_environment_firewall_options" "gitlab" {
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
  vm_id         = var.gitlab.vm_id
}

# __generated__ by OpenTofu from "vm/proxmox/102"
resource "proxmox_virtual_environment_firewall_rules" "homeassistant" {
  provider     = proxmox.opentofu
  container_id = null
  node_name    = var.node_1.name
  vm_id        = var.homeassistant.vm_id
}

# __generated__ by OpenTofu from "container/proxmox/101"
resource "proxmox_virtual_environment_firewall_rules" "pihole" {
  provider     = proxmox.opentofu
  container_id = var.pihole.ct_id
  node_name    = var.node_1.name
  vm_id        = null
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

# __generated__ by OpenTofu from "vm/proxmox/999"
resource "proxmox_virtual_environment_firewall_options" "ubuntu_server_2024_template" {
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
  vm_id         = var.ubuntu_server_2024_template.vm_id
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
    # config and backup of the homepage config to do this
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
    type             = "debian"
  }
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

# __generated__ by OpenTofu
resource "proxmox_virtual_environment_vm" "ubuntu_server_2024_template" {
  provider                             = proxmox.opentofu
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["scsi0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = "## TODO  \n- `truncate -s 0 /etc/machine-id /var/lib/dbus/machine-id`  \n- turn into template\n- `hostnamectl set-hostname <newhostname>`\n- `passwd` to change user name"
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = ""
  machine                              = ""
  migrate                              = false
  name                                 = "ubuntu-server-2024-template"
  node_name                            = var.node_1.name
  on_boot                              = false
  protection                           = false
  purge_on_destroy                     = true
  reboot                               = false
  reboot_after_update                  = true
  scsi_hardware                        = "virtio-scsi-single"
  started                              = false
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
  vm_id                                = var.ubuntu_server_2024_template.vm_id
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
    type         = "x86-64-v2-AES"
    units        = 1024
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = ""
    import_from       = ""
    interface         = "scsi0"
    iothread          = true
    path_in_datastore = "vm-999-disk-0"
    replicate         = true
    serial            = ""
    size              = 64
    ssd               = false
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
    mac_address  = "BC:24:11:DF:F2:0B"
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

# __generated__ by OpenTofu
resource "proxmox_virtual_environment_vm" "gitlab" {
  provider                             = proxmox.opentofu
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["scsi0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = "## TODO  \n- `truncate -s 0 /etc/machine-id /var/lib/dbus/machine-id`  \n- turn into template"
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = ""
  machine                              = ""
  migrate                              = false
  name                                 = "gitlab"
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
  vm_id                                = var.gitlab.vm_id
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
    type         = "x86-64-v2-AES"
    units        = 1024
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = ""
    import_from       = ""
    interface         = "scsi0"
    iothread          = true
    path_in_datastore = "vm-105-disk-0"
    replicate         = true
    serial            = ""
    size              = 64
    ssd               = false
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
    mac_address  = "BC:24:11:59:EA:69"
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

# __generated__ by OpenTofu
resource "proxmox_virtual_environment_vm" "bookstack" {
  provider                             = proxmox.opentofu
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
  name                                 = "bookstack"
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
  vm_id                                = var.bookstack.vm_id
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
    type         = "x86-64-v2-AES"
    units        = 1024
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = ""
    import_from       = ""
    interface         = "scsi0"
    iothread          = true
    path_in_datastore = "vm-100-disk-0"
    replicate         = true
    serial            = ""
    size              = 64
    ssd               = false
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
    mac_address  = "BC:24:11:CF:07:24"
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

# __generated__ by OpenTofu
resource "proxmox_virtual_environment_vm" "homeassistant" {
  provider                             = proxmox.opentofu
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
    datastore_id      = "local-lvm"
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
  efi_disk {
    datastore_id      = "local-lvm"
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

# __generated__ by OpenTofu
resource "proxmox_virtual_environment_vm" "nginx_proxy_manager" {
  provider                             = proxmox.opentofu
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
    datastore_id      = "local-lvm"
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
