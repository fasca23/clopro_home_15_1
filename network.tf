# Создаем пустую VPC
resource "yandex_vpc_network" "network" {
  name = "my-vpc-network"
}
# Публичная подсеть public 192.168.10.0/24
resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
# Приватная подсеть private 192.168.20.0/24
resource "yandex_vpc_subnet" "private" {
  name           = "private"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = yandex_vpc_route_table.private_route_table.id
}
# Route table для приватной подсети
resource "yandex_vpc_route_table" "private_route_table" {
  name       = "private-route-table"
  network_id = yandex_vpc_network.network.id
  # Маршрут по умолчанию через NAT-инстанс
  static_route {
    destination_prefix = "0.0.0.0/0" # Весь трафик
    next_hop_address   = var.nat_instance_ip # 192.168.10.254 по заданию
  }
}