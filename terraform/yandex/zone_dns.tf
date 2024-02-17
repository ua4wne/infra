resource "yandex_dns_zone" "deviot" {
  name        = "deviot-zone"
  zone             = "deviot.ru."
  public           = true
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.deviot.id
  name    = "deviot.ru."
  type    = "A"
  ttl     = 200
  data    = yandex_lb_network_load_balancer.lb-test.listener.*.external_address_spec[0].*.address
}

resource "yandex_dns_recordset" "rs2" {
  zone_id = yandex_dns_zone.deviot.id
  name    = "monitoring.deviot.ru."
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.vm-prometheus.network_interface[0].nat_ip_address]
}

resource "yandex_dns_recordset" "rs3" {
  zone_id = yandex_dns_zone.deviot.id
  name    = "grafana.deviot.ru."
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.vm-grafana.network_interface[0].nat_ip_address]
}