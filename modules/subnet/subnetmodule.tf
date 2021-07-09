resource "azurerm_subnet" "subnet" {
  name                 = var.subnetname
  virtual_network_name = var.vnetname01
  address_prefixes     = var.subnet_address_space
  resource_group_name = var.rgname
}