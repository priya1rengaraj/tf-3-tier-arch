variable "resource_group_name" {}
variable "location" {}
variable "app_subnet_id" {}
variable "db_subnet_id" {}

variable "nat_pip_name" {
  type    = string
  default = "nat-pip"
}
variable "nat_name" {
  type    = string
  default = "nat"
}
