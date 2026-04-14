resource "azurerm_linux_virtual_machine_scale_set" "app_vmss" {
  name                            = var.app_vmss_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  sku                             = var.app_sku_size
  instances                       = var.app_instance_count
  admin_username                  = "adminuser"
  admin_password                  = "Admin@1234567"
  disable_password_authentication = false
  zones                           = ["1", "2"]
  upgrade_mode                    = "Manual"

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${var.app_vmss_name}-nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = var.app_subnet_id
      load_balancer_backend_address_pool_ids = [var.private_lb_back_pool_id]
    }
  }
    extension {
    name                       = "nginx-install-extension"
    publisher                  = "Microsoft.Azure.Extensions"
    type                       = "CustomScript"
    type_handler_version       = "2.1"
    auto_upgrade_minor_version = true

    settings = <<SETTINGS
   {
      "fileUris": ["https://commonstorageaccount6799.blob.core.windows.net/custom-extension-container/tomcat.sh"],
        "commandToExecute": "chmod +x tomcat.sh && ./tomcat.sh"
   }
  SETTINGS
  }
}




