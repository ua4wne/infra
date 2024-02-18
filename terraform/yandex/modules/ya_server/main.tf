terraform {
  required_version = "= 1.7.3"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      #      version = ">= 0.73"
    }
  }
}

data "yandex_compute_image" "os_image" {
  family = var.os_family
}

resource "yandex_compute_instance" "vm" {
  count                     = var.cnt
  name                      = "vm-${var.env}-${count.index}"
  allow_stopping_for_update = var.allow_stopping

  resources {
    core_fraction = var.env == "prod" ? 10 : 5 # Гарантированная доля vCPU
    cores         = var.env == "prod" ? 4 : 2  # vCPU
    memory        = var.env == "prod" ? 2 : 1
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os_image.id
    }
  }

  network_interface {
    subnet_id = var.network_id
    nat       = var.nat
  }

  metadata = {
    ssh-keys = var.ssh_keys
  }

  # прерываемая ВМ
  scheduling_policy {
    preemptible = var.env == "prod" ? false : true
  }

  platform_id = var.platform_id

}
