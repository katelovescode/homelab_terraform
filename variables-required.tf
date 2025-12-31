variable "cluster" {
  type = object({
    endpoint = string
  })
  description = "Proxmox cluster info"
  nullable    = false
}

variable "node_1" {
  type = object({
    name            = string
    ip_address      = string
    cidr            = string
    image_datastore = string
    disk_datastore  = string
  })
  description = "Proxmox node 1 info"
  nullable    = false
}

variable "root_user" {
  type = object({
    password = string
    username = string
  })
  description = "Proxmox root user data"
  sensitive   = true
  nullable    = false
}

variable "admin_user" {
  type = object({
    username   = string
    email      = string
    password   = string
    first_name = string
    last_name  = string
    realm      = string
    public_key = string
  })
  description = "Proxmox admin user data"
  sensitive   = true
  nullable    = false
}

variable "opentofu_user" {
  type = object({
    password   = string
    api_token  = string
    token_name = string
    realm      = string
    username   = string
  })
  description = "Proxmox opentofu user data"
  sensitive   = true
  nullable    = false
}

variable "homepage_user" {
  type = object({
    password   = string
    api_token  = string
    token_name = string
    realm      = string
    username   = string
  })
  description = "Proxmox homepage user data"
  sensitive   = true
  nullable    = false
}

variable "homeassistant_user" {
  type = object({
    password   = string
    api_token  = string
    token_name = string
    realm      = string
    username   = string
  })
  description = "Proxmox homeassistant user data"
  sensitive   = true
  nullable    = false
}

variable "letsencrypt" {
  type = object({
    digest   = string
    cf_token = string
  })
  description = "Let's Encrypt auth data"
  sensitive   = true
  nullable    = false
}

variable "dns" {
  type = object({
    gateway = string
  })
  description = "DNS and IP information"
  nullable    = false
}

variable "pihole" {
  type = object({
    ct_id      = string
    ip_address = string
    admin_user = object({
      username = string
      password = string
    })
  })
  description = "PiHole container information"
  nullable    = false
}

variable "homepage" {
  type = object({
    ct_id      = string
    ip_address = string
    admin_user = object({
      username = string
      password = string
    })
  })
  description = "Homepage container information"
  nullable    = false
}

variable "ubuntu_server_2024_template" {
  type = object({
    vm_id      = string
    ip_address = string
    admin_user = object({
      password = string
      username = string
    })
  })
  description = "Ubuntu Server 2024 Template VM information"
  nullable    = false
}

variable "bookstack" {
  type = object({
    vm_id      = string
    ip_address = string
    admin_user = object({
      username = string
      password = string
    })
  })
  description = "Bookstack VM information"
  nullable    = false
}

variable "nginx_proxy_manager" {
  type = object({
    vm_id      = string
    ip_address = string
    admin_user = object({
      username = string
      password = string
    })
  })
  description = "NGINX Proxy Manager VM information"
  nullable    = false
}

variable "gitlab" {
  type = object({
    vm_id      = string
    ip_address = string
    admin_user = object({
      username = string
      password = string
    })
  })
  description = "Gitlab VM information"
  nullable    = false
}

variable "homeassistant" {
  type = object({
    vm_id      = string
    ip_address = string
    admin_user = object({
      username = string
    })
  })
  description = "Gitlab VM information"
  nullable    = false
}