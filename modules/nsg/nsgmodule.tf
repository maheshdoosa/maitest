resource "azurerm_network_security_group" "nsg" {
  name                = var.nsgname
  location            = var.nsg_location
  resource_group_name = var.rgname
}