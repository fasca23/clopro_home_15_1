# NAT-инстанс в публичной подсети
resource "yandex_compute_instance" "nat_instance" {
  name        = "nat-instance"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image_id # Специальный образ NAT от Yandex
      size     = var.disk_size
    }
  }
  # NAT-инстанс с адресом 192.168.10.254
  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id # Публичная подсеть
    ip_address = var.nat_instance_ip # 192.168.10.254 по заданию
    nat        = true # Публичный IP для NAT
  }

  metadata = {
    ssh-keys = "${var.vm_username}:${file(var.ssh_public_key_path)}"
  }
}