data "yandex_compute_image" "last_ubuntu" {
  family = "ubuntu-2204-lts"  # ОС (Ubuntu, 22.04 LTS)
}

resource "yandex_compute_instance" "vm-test1" {
  name                      = "vm-test1"
  allow_stopping_for_update = true

  resources {
    core_fraction = 5 # Гарантированная доля vCPU
    cores  = 2 # vCPU
    memory = 1 # RAM
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.last_ubuntu.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id # одна из дефолтных подсетей
    nat = true # автоматически установить динамический ip
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  platform_id = "standard-v1" # тип процессора (Intel Broadwell)

}

# resource "yandex_compute_instance" "vm-test2" {
#   name                      = "vm-test2"
#   allow_stopping_for_update = true

#   resources {
#     cores  = 2
#     memory = 2
#   }

#   boot_disk {
#     initialize_params {
#       image_id = data.yandex_compute_image.lemp.id
#     }
#   }

#   network_interface {
#     subnet_id = yandex_vpc_subnet.subnet_terraform.id
#     nat       = true
#   }

# }

resource "yandex_vpc_network" "network_terraform" {
  name = "network_terraform"
}

resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "subnet_terraform"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.15.0/24"]
}