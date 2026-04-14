terraform {
  backend "azurerm" {
    storage_account_name = "commonstorageaccount6799"
    container_name       = "terraform-state-storage-container"
    key                  = "3tier.terraform.tfstate"
  }
}
