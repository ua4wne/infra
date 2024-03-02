terraform {
  required_version = "= 1.7.4"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      #      version = ">= 0.73"
    }
  }
}

provider "yandex" {
  token     = var.ya_token
  cloud_id  = var.ya_cloud_id
  folder_id = var.ya_folder_id
  zone      = var.ya_zone
}

# создаем сеть
module "network" {
  source = "../../modules/ya_network"
  env    = var.env
}

# создаем хосты
module "vm" {
  source         = "../../modules/ya_server"
  network_id     = module.network.network_id
  ssh_keys       = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  env            = var.env
  cnt            = 3 # создать 3 хоста
  cnt_to_balance = 1 # один хост в балансировку
  depends_on     = [module.network]
}

# создаем балансировщик
module "balancer" {
  source     = "../../modules/ya_balancer"
  subnet_id  = module.network.network_id
  address    = module.vm.internal_ip_to_balance
  env        = var.env
  depends_on = [module.vm]
}

# создаем записи DNS
module "dns_zone" {
  source       = "../../modules/ya_zone"
  public_ip_lb = module.balancer.lb_public_ip
  dns_name     = ["monitoring.deviot.ru", "grafana.deviot.ru"]
  public_ip    = [module.vm.public_ip[0], module.vm.public_ip[1]]
  env          = var.env
  depends_on   = [module.balancer]
}
