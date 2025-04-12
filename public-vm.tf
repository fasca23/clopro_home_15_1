# Виртуалка с публичным IP в публичной подсети
resource "yandex_compute_instance" "public_vm" {
  name        = "public-vm"
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
    subnet_id = yandex_vpc_subnet.public.id # Публичная подсеть
    nat       = true # Назначить публичный IP
  }

  metadata = {
    ssh-keys = "${var.vm_username}:${file(var.ssh_public_key_path)}"
    
    # Передаем приватный ключ для доступа к приватной VM
    user-data = <<-EOF
      #cloud-config
      write_files:
        - path: /home/${var.vm_username}/.ssh/internal_key
          owner: ${var.vm_username}:${var.vm_username}
          permissions: '0600'
          content: |
            ${indent(12, tls_private_key.internal_key.private_key_openssh)}
      
      runcmd:
        - chown ${var.vm_username}:${var.vm_username} /home/${var.vm_username}/.ssh/internal_key
    EOF
  }
}