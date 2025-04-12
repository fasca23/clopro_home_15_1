# Виртуалка с внутренним IP в приватной подсети
resource "yandex_compute_instance" "private_vm" {
  name        = "private-vm"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_image_id # Ubuntu 22.04
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id # Приватная подсеть
    # Нет параметра nat - только внутренний IP
  }


#   metadata = {
#     ssh-keys = "${var.vm_username}:${file(var.ssh_public_key_path)}"
#   }

  metadata = {
    # Основной админский ключ + временный внутренний ключ
    ssh-keys = <<-EOT
      ${var.vm_username}:${file(var.ssh_public_key_path)}
      ${var.vm_username}:${tls_private_key.internal_key.public_key_openssh}
    EOT
    
    # Настройка SSH для автоматического подключения
    user-data = <<-EOF
      #cloud-config
      ssh_pwauth: false
      disable_root: true
    EOF
  }
}