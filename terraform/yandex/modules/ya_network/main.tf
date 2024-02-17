terraform {
  required_version = "= 1.7.3"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
#      version = ">= 0.73"
    }
  }
}

resource "yandex_vpc_network" "network_terraform" {
  name = "network_terraform"
}

resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "subnet-${var.env}"
  zone           = var.zone
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = var.v4_cidr
}
