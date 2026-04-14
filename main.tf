module "network" {
  source = "./network"

  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
}

module "subnet" {
  source = "./subnet"

  subnet1_name        = var.subnet1_name
  subnet2_name        = var.subnet2_name
  subnet3_name        = var.subnet3_name
  resource_group_name = module.network.resource_group_name
  vnet_name           = module.network.vnet_name
}

module "nsg" {
  source = "./nsg"

  subnet1_nsg_name    = var.subnet1_nsg_name
  subnet2_nsg_name    = var.subnet2_nsg_name
  subnet3_nsg_name    = var.subnet3_nsg_name
  resource_group_name = module.network.resource_group_name
  location            = module.network.resource_group_location
  web_subnet_id       = module.subnet.web_subnet_id
  app_subnet_id       = module.subnet.app_subnet_id
  db_subnet_id        = module.subnet.db_subnet_id
}

module "nat" {
  source              = "./nat"
  nat_pip_name        = var.nat_pip_name
  nat_name            = var.nat_name
  location            = module.network.resource_group_location
  resource_group_name = module.network.resource_group_name
  app_subnet_id       = module.subnet.app_subnet_id
  db_subnet_id        = module.subnet.db_subnet_id
}

module "public_lb" {
  source = "./public_lb"

  public_lb_pip_name  = var.public_lb_pip_name
  public_lb_name      = var.public_lb_name
  resource_group_name = module.network.resource_group_name
  location            = module.network.resource_group_location

  depends_on = [module.subnet]
}

module "internal_lb" {
  source = "./internal_lb"

  private_lb_name     = var.private_lb_name
  resource_group_name = module.network.resource_group_name
  location            = module.network.resource_group_location
  app_subnet_id       = module.subnet.app_subnet_id

  depends_on = [module.subnet]
}

module "vmss-web" {
  source = "./vmss-web"

  web_vmss_name          = var.web_vmss_name
  web_sku_size           = var.web_sku_size
  web_instance_count     = var.web_instance_count
  resource_group_name    = module.network.resource_group_name
  location               = module.network.resource_group_location
  web_subnet_id          = module.subnet.web_subnet_id
  public_lb_back_pool_id = module.public_lb.public_lb_back_pool_id

  depends_on = [module.public_lb]
}

module "vmss-app" {
  source = "./vmss-app"

  app_vmss_name           = var.app_vmss_name
  app_sku_size            = var.app_sku_size
  app_instance_count      = var.app_instance_count
  resource_group_name     = module.network.resource_group_name
  location                = module.network.resource_group_location
  app_subnet_id           = module.subnet.app_subnet_id
  private_lb_back_pool_id = module.internal_lb.private_lb_back_pool_id

  depends_on = [module.internal_lb]
}

module "mysql-db" {
  source              = "./mysql"
  resource_group_name = module.network.resource_group_name
  location            = module.network.resource_group_location
  vnet_id             = module.network.vnet_id
  db_subnet_id        = module.subnet.db_subnet_id
}

module "dns" {
  source              = "./dns"
  resource_group_name = module.network.resource_group_name
  dns_zone_name       = "rvpmtech.shop"
  public_ip_address   = module.public_lb.public_ip_address

  depends_on  = [module.public_lb]
  target_fqdn = module.public_lb.lb_fqdn
}

