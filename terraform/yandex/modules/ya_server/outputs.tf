output "internal_ip_to_balance" {
  value = [
    for i, x in yandex_compute_instance.vm :
    x.network_interface.0.ip_address
    if i < var.cnt_to_balance
  ]
}

output "public_ip" {
  # value = yandex_compute_instance.vm[*].network_interface[0].nat_ip_address
  value = [
    for i, x in yandex_compute_instance.vm[*].network_interface.0 :
    x.nat_ip_address
    if i >= var.cnt_to_balance
  ]
}
