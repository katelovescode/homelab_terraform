# __generated__ by OpenTofu from "kate@pam"
resource "proxmox_virtual_environment_user" "admin_user" {
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