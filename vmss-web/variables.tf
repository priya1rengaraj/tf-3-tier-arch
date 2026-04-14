
variable "web_vmss_name" {
  type    = string
  default = "web-vmss"
}
variable "web_sku_size" {
  type    = string
  default = "Standard_B1s"
}
variable "web_instance_count" {
  type    = number
  default = 2
}
variable "resource_group_name" {}
variable "location" {}
variable "web_subnet_id" {

}
variable "public_lb_back_pool_id" {}