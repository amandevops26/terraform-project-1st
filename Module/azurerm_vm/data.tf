data"azurerm_subnet" "amanvm" {
    for_each = var.amanvm
    name                 = each.value.nic_subnet_name
    virtual_network_name = each.value.nic_vnet_name
    resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "amanvm" {
    for_each = var.amanvm
    name                = each.value.nic_pip_name
    resource_group_name = each.value.resource_group_name
}