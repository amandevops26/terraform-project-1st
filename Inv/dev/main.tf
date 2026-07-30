module "azurerm_resource_group" {
  source = "../../Module/azurerm_rg"
  amanrg = var.amanrg1
}

module "azurerm_virtual_network" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../Module/azurerm_vnet"
  amanvnet   = var.amanvnet1
}

module "azurerm_subnet" {
  depends_on = [module.azurerm_virtual_network]
  source     = "../../Module/azurerm_subnet"
  amansubnet = var.amansubnet1
}

module "azurerm_" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../Module/azurerm_pip"
  amanpip    = var.amanpip1
}

module "azurerm_vm" {
  depends_on = [module.azurerm_subnet, module.azurerm_pip]
  source     = "../../Module/azurerm_vm"
  amanvm     = var.amanvm
}