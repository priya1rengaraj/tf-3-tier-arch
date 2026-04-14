output "web_subnet_id" {
  value = azurerm_subnet.subnet1.id
}
output "app_subnet_id" {
  value = azurerm_subnet.subnet2.id
}
output "db_subnet_id" {
  value = azurerm_subnet.subnet3.id
}