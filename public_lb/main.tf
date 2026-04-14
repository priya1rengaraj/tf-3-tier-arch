
resource "azurerm_public_ip" "lb_pip" {
  name                = var.public_lb_pip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
 # to access the public IP via DNS name. Instead of hitting the public IP in the browser, you can hit the DNS name which is easier to remember. The DNS name will be in the format <domain_name_label>.<region>.cloudapp.azure.com}
  domain_name_label = var.domain_name_label    
}

resource "azurerm_lb" "public_lb" {
  name                = var.public_lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_pip.id  
    # attaching the public IP to the frontend configuration of the load balancer
  }
}
resource "azurerm_lb_backend_address_pool" "public_lb_back_pool" {
  loadbalancer_id = azurerm_lb.public_lb.id
  name            = "web-subnet-BackEndAddressPool"
}
resource "azurerm_lb_probe" "example" {
  loadbalancer_id     = azurerm_lb.public_lb.id
  name                = "httpProbe"
  port                = 80
  protocol            = "Http"
  interval_in_seconds = 10
  number_of_probes    = 2
  request_path        = "/"

  depends_on = [ azurerm_lb.public_lb ]
}

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.public_lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.example.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.public_lb_back_pool.id]

  depends_on = [ azurerm_lb.public_lb, azurerm_lb_probe.example ]
}










