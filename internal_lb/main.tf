
resource "azurerm_lb" "private_lb" {
  name                = var.private_lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                          = "internal-lb-frontend-ip"
    subnet_id                     = var.app_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.20"

  }
}
resource "azurerm_lb_backend_address_pool" "private_lb_back_pool" {
  loadbalancer_id = azurerm_lb.private_lb.id
  name            = "app-subnet-BackEndAddressPool"
}

resource "azurerm_lb_probe" "private_lb_probe" {
  loadbalancer_id     = azurerm_lb.private_lb.id
  name                = "tomcat_probe"
  port                = 8080
  protocol            = "Http"
  request_path        = "/"
  interval_in_seconds = 10
  number_of_probes    = 2

  depends_on = [ azurerm_lb.private_lb ]

}
resource "azurerm_lb_rule" "private_lb_rule" {
  loadbalancer_id                = azurerm_lb.private_lb.id
  name                           = "web_to_app_LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = "internal-lb-frontend-ip"
  probe_id                       = azurerm_lb_probe.private_lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.private_lb_back_pool.id]

  depends_on = [ azurerm_lb.private_lb, azurerm_lb_probe.private_lb_probe ]

}