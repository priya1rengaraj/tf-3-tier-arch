output "web_nsg_id" {
  value = azurerm_network_security_group.subnet1-nsg.id
}

output "app_nsg_id" {
  value = azurerm_network_security_group.subnet2-nsg.id
}
output "db_nsg_id" {
  value = azurerm_network_security_group.subnet3-nsg.id
}