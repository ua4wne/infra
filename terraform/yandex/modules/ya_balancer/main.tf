terraform {
  required_version = "= 1.7.4"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      #      version = ">= 0.73"
    }
  }
}

resource "yandex_lb_network_load_balancer" "lb-test" {
  name = "lb-${var.env}"

  listener {
    name = "${var.env}-listener-web-servers"
    port = var.port
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.web-servers.id

    healthcheck {
      name = "http"
      http_options {
        port = var.port
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "web-servers" {
  name = "web-servers-target-group"

  dynamic "target" {
    for_each = var.address
    content {
      subnet_id = var.subnet_id
      address   = target.value
    }
  }

}
