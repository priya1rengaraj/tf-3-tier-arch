

resource "azurerm_linux_virtual_machine_scale_set" "web_vmss" {
  name                            = var.web_vmss_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  sku                             = var.web_sku_size
  instances                       = var.web_instance_count
  admin_username                  = "adminuser"
  admin_password                  = "Admin@1234567"
  disable_password_authentication = false

  zones = ["1", "2"]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    disk_size_gb         = 30
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  network_interface {
    name    = "${var.web_vmss_name}-nic"
    primary = true


    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.web_subnet_id

      load_balancer_backend_address_pool_ids = [var.public_lb_back_pool_id]
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
      "fileUris": ["https://commonstorageaccount6799.blob.core.windows.net/custom-extension-container/nginx.sh"],
        "commandToExecute": "chmod +x nginx.sh && ./nginx.sh"
   }
  SETTINGS
  }
}



