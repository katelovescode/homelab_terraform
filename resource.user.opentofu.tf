# __generated__ by OpenTofu from "OpenTofu"
resource "proxmox_virtual_environment_role" "opentofu_role" {
  provider = proxmox
  privileges = [
    "Datastore.Allocate",
    "Datastore.AllocateTemplate",
    "Datastore.Audit",
    "Group.Allocate",
    "Mapping.Audit",
    "Permissions.Modify",
    "Pool.Audit",
    "SDN.Audit",
    "SDN.Use",
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
  provider = proxmox
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
  provider        = proxmox
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
  provider              = proxmox
  comment               = "Managed by OpenTofu"
  expiration_date       = null
  privileges_separation = false
  token_name            = var.opentofu_user.token_name
  user_id               = join("", [var.opentofu_user.username, "@", var.opentofu_user.realm])
}

