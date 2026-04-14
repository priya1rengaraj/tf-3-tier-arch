variable "resource_group_name" {
  type    = string
  default = "3tier-rg"
}
variable "location" {
  type    = string
  default = "centralindia"
}
variable "vnet_name" {
  type    = string
  default = "vnet-1"
}
variable "subnet1_name" {
  type    = string
  default = "web_subnet"
}
variable "subnet2_name" {
  type    = string
  default = "app_subnet"
}
variable "subnet3_name" {
  type    = string
  default = "db_subnet"
}
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
  default = 1
}
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
  default = 1
}
variable "subnet1_nsg_name" {
  type    = string
  default = "web-subnet-nsg"
}
variable "subnet2_nsg_name" {
  type    = string
  default = "app-subnet-nsg"
}
variable "subnet3_nsg_name" {
  type    = string
  default = "db-subnet-nsg"
}
variable "public_lb_pip_name" {
  type    = string
  default = "public-lb-pip"
}
variable "public_lb_name" {
  type    = string
  default = "public-frontend-lb"
}
variable "private_lb_name" {
  type    = string
  default = "private-lb"
}
variable "nat_pip_name" {
  type    = string
  default = "nat-pip"
}
variable "nat_name" {
  type    = string
  default = "nat"
}
variable "dns_zone_name" {
  type    = string
  default = "rvpmtech.shop"
}

