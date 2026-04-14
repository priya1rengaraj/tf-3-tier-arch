resource "azurerm_public_ip" "nat_pip" {
  name                = var.nat_pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat" {
  name                = var.nat_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "nat_assoc_nat_pip" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.nat_pip.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_assoc_app_subnet" {
  subnet_id      = var.app_subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}
resource "azurerm_subnet_nat_gateway_association" "nat_assoc_db_subnet" {
  subnet_id      = var.db_subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}
