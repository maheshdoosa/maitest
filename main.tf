module resoucegroup01 {
    source              = "./modules/rg"
    rgname              = "${local.prefix}-ss7"
    rglocation          = "northeurope"
}
module resoucegroup02 {
    source              = "./modules/rg"
    rgname              = "nhy"
    rglocation          = "eastus"
}
module vnet01 {
    source              = "./modules/vnet"
    vnetname01          = "ss7vnet01"
    rgname              = "${local.prefix}-ss7"
    vnet_address_space  = ["10.0.0.0/16"]
    vnet_location       = "westus"
     depends_on         = [
    module.resoucegroup01,
  ]
}
module vnet02 {
    source              = "./modules/vnet"
    vnetname01          = "ss7vnet02"
    rgname              = "${local.prefix}-ss7"
    vnet_address_space  = ["11.0.0.0/16"]
    vnet_location       = "eastus2"
      depends_on        = [
    module.resoucegroup01,
  ]
}
module vnet03 {
    source              = "./modules/vnet"
    vnetname01          = "nhyvnet02"
    rgname              = "nhy"
    vnet_address_space  = ["12.0.0.0/16"]
    vnet_location       = "eastus"
      depends_on        = [
    module.resoucegroup02,
  ]
}
module subnet01 {
    source              = "./modules/subnet"
    subnetname          = "nhysubnet01"
    vnetname01          = "nhyvnet02"
    rgname              = "nhy"
    subnet_address_space = ["12.0.1.0/24"]
     depends_on         = [
    module.vnet03,
  ]
}
module subnet02 {
    source              = "./modules/subnet"
    subnetname          = "ss7subnet02"
    vnetname01          = "ss7vnet01"
    rgname              = "${local.prefix}-ss7"
    subnet_address_space = ["10.0.1.0/24"]
     depends_on         = [
    module.vnet01,
  ]
}
module subnet03 {
    source              = "./modules/subnet"
    subnetname          = "ss7subnet03"
    vnetname01          = "ss7vnet01"
    subnet_address_space = ["10.0.2.0/24"]
    rgname              = "${local.prefix}-ss7"
     depends_on         = [
    module.vnet01,
  ]
}
 data "azurerm_resource_group" "existing" {
     name               = "MAi"
}
module vnet04 {
    source              = "./modules/vnet"
    vnetname01          = "MAivnet02"
    rgname              = data.azurerm_resource_group.existing.name
    vnet_address_space  = ["18.0.0.0/16"]
    vnet_location       = data.azurerm_resource_group.existing.location
}
module subnet04 {
    source              = "./modules/subnet"
    subnetname          = "maisubnet04"
    vnetname01          = "MAivnet02"
    subnet_address_space = ["18.0.2.0/24"]
    rgname              = data.azurerm_resource_group.existing.name
     depends_on         = [
    module.vnet04,
  ]
}
module nsg01 {
    source              = "./modules/nsg"
    nsgname             = "ss7nsg"
    nsg_location        = "westeurope"
    rgname              = "${local.prefix}-ss7"
      depends_on        = [
    module.resoucegroup01,
  ]
}
module nsg02 {
    source              = "./modules/nsg"
    nsgname             = "nhynsg"
    nsg_location        = "eastus"
    rgname              = "nhy"
      depends_on        = [
    module.resoucegroup02,
  ]
}
module nsg03 {
    source              = "./modules/nsg"
    nsgname             = "mainsg"
    nsg_location        = data.azurerm_resource_group.existing.location
    rgname              = data.azurerm_resource_group.existing.name
}
