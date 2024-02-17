terraform {
  required_version = "= 1.7.3"

  required_providers {
    yandex = {
      source = "registry.terraform.io/yandex-cloud/yandex"
      #      version = ">= 0.73"
    }
  }
}

data "yandex_compute_image" "last_ubuntu" {
  family = "ubuntu-2204-lts" # ОС (Ubuntu, 22.04 LTS)
}

provider "yandex" {
  token     = var.ya_token
  cloud_id  = var.ya_cloud_id
  folder_id = var.ya_folder_id
  zone      = var.ya_zone
}

module "network" {
  source = "../../modules/ya_network"
}

# создаем хосты для балансировщика
module "vm" {
  source         = "../../modules/ya_server"
  network_id     = module.network.network_id
  ssh_keys       = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  cnt            = 3 # создать 3 хоста
  cnt_to_balance = 1 # один хост в балансировку
  depends_on     = [module.network]
}

module "balancer" {
  source    = "../../modules/ya_balancer"
  subnet_id = module.network.network_id
  address   = module.vm.internal_ip_to_balance

  depends_on = [module.vm]
}

module "dns_zone" {
  source       = "../../modules/ya_zone"
  public_ip_lb = module.balancer.lb_public_ip
  dns_name     = ["monitoring.deviot.ru", "grafana.deviot.ru"]
  public_ip    = flatten(module.vm.public_ip)

  depends_on = [module.balancer]
}
