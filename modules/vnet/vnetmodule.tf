resource "azurerm_virtual_network" "vnet" {
    name                = var.vnetname01
    address_space       = var.vnet_address_space
    location            = var.vnet_location
    resource_group_name = var.rgname
}