output "public_vm_external_ip" {
  value = yandex_compute_instance.public_vm.network_interface.0.nat_ip_address
}

output "private_vm_internal_ip" {
  value = yandex_compute_instance.private_vm.network_interface.0.ip_address
}

output "connection_command" {
  value = <<-EOT
    # Подключение к приватной VM через публичную:
    ssh -i ${var.internal_ssh_key_path} ${var.vm_username}@${yandex_compute_instance.private_vm.network_interface.0.ip_address}
    
    # Или так...:
    ssh -J ${var.vm_username}@${yandex_compute_instance.public_vm.network_interface.0.nat_ip_address} ${var.vm_username}@${yandex_compute_instance.private_vm.network_interface.0.ip_address}
  EOT
}