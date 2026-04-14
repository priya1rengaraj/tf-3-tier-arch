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
variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]

}
