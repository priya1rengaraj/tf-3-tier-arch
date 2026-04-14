# import command as dns zone is already created in the portal
# terraform import module.<module-name>.<resource-type>.<local-name> <resource-id>
resource "azurerm_dns_zone" "dns_zone" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name
}


resource "azurerm_dns_a_record" "root_a_record" {
  name                = "@"
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [var.public_ip_address]
}


resource "azurerm_dns_cname_record" "www_cname_record" {
  name                = "www"
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  record              = var.target_fqdn
  
}



# terraform import module.dns.azurerm_dns_zone.dns_zone /subscriptions/cd7effe0-ac7e-4452-9f47-c0129566996c/resourceGroups/dns-rg/providers/Microsoft.Network/dnszones/rvpmtech.shop

# terraform graph | dot -Tpng > graph.png     -->> debug command

