terraform {
  required_version = "= 1.6.6"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
#      version = ">= 0.73"
    }
  }
}

data "yandex_compute_image" "last_ubuntu" {
  family = "ubuntu-2204-lts"  # ОС (Ubuntu, 22.04 LTS)
}

# data "yandex_compute_image" "lamp" {
#   family = "lamp"  # LAMP
# }

# data "yandex_compute_image" "lemp" {
#   family = "lemp"  # LEMP
# }


provider "yandex" {
  token = var.ya_token
  cloud_id  = var.ya_cloud_id
  folder_id = var.ya_folder_id
  zone      = var.ya_zone
}

