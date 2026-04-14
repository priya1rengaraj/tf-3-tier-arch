variable "resource_group_name" {}
variable "location" {}
variable "app_subnet_id" {}
variable "private_lb_back_pool_id" {}

variable "app_vmss_name" {
  type    = string
  default = "app-vmss"
}
variable "app_sku_size" {
  type    = string
  default = "Standard_B1s"
}
variable "app_instance_count" {
  type    = number
  default = 2
}


