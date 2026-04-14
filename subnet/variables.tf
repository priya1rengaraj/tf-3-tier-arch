
variable "resource_group_name" {}
variable "vnet_name" {}

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

