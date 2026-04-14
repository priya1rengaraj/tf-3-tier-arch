output "public_ip_id" {
  value = azurerm_public_ip.lb_pip.id
}
output "public_lb_back_pool_id" {
  value = azurerm_lb_backend_address_pool.public_lb_back_pool.id
}
output "public_ip_address" {
  value = azurerm_public_ip.lb_pip.ip_address
}
output "lb_fqdn" {
  value = azurerm_public_ip.lb_pip.fqdn
}