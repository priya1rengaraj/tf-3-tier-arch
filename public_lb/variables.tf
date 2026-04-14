variable "public_lb_pip_name" {
  type    = string
  default = "public-lb-pip"
}
variable "public_lb_name" {
  type    = string
  default = "public-frontend-lb"
}
variable "domain_name_label" {
  type    = string
  default = "rvpm1994"
  
}

variable "resource_group_name" {}
variable "location" {}
