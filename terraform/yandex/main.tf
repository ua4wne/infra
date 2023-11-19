terraform {
  required_version = "= 1.4.5"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
#      version = ">= 0.73"
    }
  }
}

provider "yandex" {
  token = "y0_AgAAAAAMBQS7AATuwQAAAADf0uwNHgvmHmr4RpuxS9InFbKKk3j-RO0"
  cloud_id  = "b1gp8lr5vq4et15ermu8"
  folder_id = "b1gq441l9n1pl3gc9n47"
  zone      = "ru-central1-a"
}

