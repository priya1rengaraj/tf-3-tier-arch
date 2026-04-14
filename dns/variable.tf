variable "dns_zone_name" {
  type = string
  default = "rvpmtech.shop"
}

variable "resource_group_name" {}
variable "public_ip_address" {}

variable "target_fqdn" {
  description = "FQDN of public IP"
  type        = string
}