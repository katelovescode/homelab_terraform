resource "proxmox_virtual_environment_user" "root_user" {
  comment  = "Managed by OpenTofu"
  user_id  = var.root_user.username
  email    = var.admin_user.email
  password = var.root_user.password
}

