# Генерируем временный SSH-ключ для связи между VM
resource "tls_private_key" "internal_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Сохраняем приватный ключ локально (для отладки)
resource "local_file" "internal_private_key" {
  content  = tls_private_key.internal_key.private_key_openssh
  filename = var.internal_ssh_key_path
  file_permission = "0600"
}