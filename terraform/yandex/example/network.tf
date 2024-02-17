resource "yandex_vpc_network" "network_terraform" {
  name = "network_terraform"
}

resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "subnet_terraform"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.15.0/24"]
}