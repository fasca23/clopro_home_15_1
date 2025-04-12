# Базовые настройки
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.124.0"
    }
  }
  required_version = ">=1.9"
}

provider "yandex" {
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = var.yc_zone
  service_account_key_file = file("~/authorized_key.json")
}
