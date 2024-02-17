output "lb_ip_address" {
  value = yandex_lb_network_load_balancer.lb-test.*
}

output "vm-test1_public_ip" {
    value = yandex_compute_instance.vm-test1.network_interface[0].nat_ip_address
}

output "vm-prometheus_public_ip" {
    value = yandex_compute_instance.vm-prometheus.network_interface[0].nat_ip_address
}

output "vm-grafana_public_ip" {
    value = yandex_compute_instance.vm-grafana.network_interface[0].nat_ip_address
}

