# Yandex Cloud authentication
variable "yc_cloud_id" {
  type      = string
  sensitive = true
}

variable "yc_folder_id" {
  type      = string
  sensitive = true
}

variable "yc_zone" {
  type    = string
  default = "ru-central1-a"
}

# VM Configuration
variable "vm_username" {
  type    = string
  default = "ubuntu"
}

variable "vm_cores" {
  type    = number
  default = 2
}

variable "vm_memory" {
  type    = number
  default = 2
}

variable "disk_size" {
  type    = number
  default = 10
}

# Images
variable "vm_image_id" {
  type    = string
  default = "fd8kdq6d0p8sij7h5qe3" # Ubuntu 22.04
}

variable "nat_image_id" {
  type    = string
  default = "fd80mrhj8fl2oe87o4e1" # NAT instance
}

# Network
variable "nat_instance_ip" {
  type    = string
  default = "192.168.10.254"
}

# SSH
variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}

# Временный ключ для связи между VM
variable "internal_ssh_key_path" {
  type    = string
  default = "./internal_ssh_key"
}
