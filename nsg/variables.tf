variable "resource_group_name" {}
variable "location" {}
variable "web_subnet_id" {}
variable "app_subnet_id" {}
variable "db_subnet_id" {}

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
  default = "db-nsg"
}
