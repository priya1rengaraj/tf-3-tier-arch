
resource "azurerm_private_dns_zone" "mysql_dns" {
  name                = "rvpm6799-mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "mysql-dns-link"
  private_dns_zone_name = azurerm_private_dns_zone.mysql_dns.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group_name
}
resource "azurerm_mssql_server" "mysql_server" {
  name                         = "my-rvpm6799shop-sqlserver"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "mysqladmin"
  administrator_login_password = "Devopsuser@12345"
  minimum_tls_version          = "1.2"

  depends_on = [var.db_subnet_id]
}

resource "azurerm_mssql_database" "mysql_db" {
  name        = "mysql-db"
  server_id   = azurerm_mssql_server.mysql_server.id
  max_size_gb = 2
  sku_name    = "S0"
}
