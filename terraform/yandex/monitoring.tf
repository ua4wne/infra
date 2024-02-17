resource "yandex_compute_instance" "vm-prometheus" {
  name                      = "vm-prometheus"
  allow_stopping_for_update = true

  resources {
    core_fraction = 5 # Гарантированная доля vCPU
    cores  = 2 # vCPU
    memory = 2 # RAM
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

  # прерываемая ВМ
  scheduling_policy {
    preemptible = true
  }

  platform_id = "standard-v1" # тип процессора (Intel Broadwell)
}

resource "yandex_compute_instance" "vm-grafana" {
  name                      = "vm-grafana"
  allow_stopping_for_update = true

  resources {
    core_fraction = 5 # Гарантированная доля vCPU
    cores  = 2 # vCPU
    memory = 2 # RAM
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

  # прерываемая ВМ
  scheduling_policy {
    preemptible = true
  }

  platform_id = "standard-v1" # тип процессора (Intel Broadwell)
}