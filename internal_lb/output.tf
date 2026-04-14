output "private_lb_back_pool_id" {
  value = azurerm_lb_backend_address_pool.private_lb_back_pool.id

}

output "private_ip_address" {
  value = azurerm_lb.private_lb.frontend_ip_configuration[0].private_ip_address
}