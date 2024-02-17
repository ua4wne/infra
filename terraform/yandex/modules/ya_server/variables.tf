variable "env" {
  default = "test"
}

variable "os_family" {
  default = "ubuntu-2204-lts" # ОС (Ubuntu, 22.04 LTS)
  #   family = "lamp"  # LAMP
  #   family = "lemp"  # LEMP
}

variable "allow_stopping" {
  default = true
}

variable "cnt" {
  default = 1
}

variable "cnt_to_balance" {
  default = 1 # count instance to balance
}

variable "nat" {
  default = true # автоматически установить динамический ip
}

variable "ssh_keys" {
  default = ""
}

variable "platform_id" {
  default = "standard-v1" # тип процессора (Intel Broadwell)
}

variable "network_id" {
  default = []
}
