output "lb_public_ip" {
  #value = yandex_lb_network_load_balancer.lb-test.*
  value = [for s in yandex_lb_network_load_balancer.lb-test.listener: s.external_address_spec.*.address].0
}
