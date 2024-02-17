variable "env" {
  default = "test"
}

variable "zone" {
  default = "deviot.ru"
}

variable "dns_name" {
  default = ["deviot.ru"]
}

variable "is_public" {
  default = true
}

variable "public_ip_lb" {
  default = []
}

variable "public_ip" {
  default = []
}
