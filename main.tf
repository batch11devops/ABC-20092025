provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-module-demo"
  location = "East US"
}

# VNet1 using module
module "vnet1" {
  source              = "./modules/vnet"
  vnet_name           = "vnet1"
  address_space       = ["10.5.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_name         = "subnet1"
  subnet_prefixes     = ["10.5.0.0/24"]
}

# VNet2 using module
module "vnet2" {
  source              = "./modules/vnet"
  vnet_name           = "vnet2"
  address_space       = ["10.15.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_name         = "subnet2"
  subnet_prefixes     = ["10.15.0.0/24"]
}

# VNet Peering VNet1 -> VNet2
resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  name                      = "vnet1-to-vnet2"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_id        = module.vnet1.vnet_id
  remote_virtual_network_id = module.vnet2.vnet_id

  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}

# VNet Peering VNet2 -> VNet1
resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
  name                      = "vnet2-to-vnet1"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_id        = module.vnet2.vnet_id
  remote_virtual_network_id = module.vnet1.vnet_id

  allow_forwarded_traffic      = true
  allow_virtual_network_access = true
}

