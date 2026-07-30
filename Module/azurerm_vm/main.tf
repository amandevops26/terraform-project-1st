resource "azurerm_network_interface" "amanvmnic" {
    for_each = var.amanvm
    name                = each.value.nic_name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    ip_configuration {
        name                          = each.value.ip_name
        subnet_id                     = data.azurerm_subnet.amanvm[each.key].id
        private_ip_address_allocation = each.value.private_ip_address_allocation
        public_ip_address_id          = data.azurerm_public_ip.amanvm[each.key].id
    }
}

resource "azurerm_linux_virtual_machine" "amanvm" {
    for_each = var.amanvm
    name                  = each.value.vm_name
    resource_group_name   = each.value.resource_group_name
    location              = each.value.location
    size                  = each.value.vm_size
    admin_username        = each.value.admin_username
    admin_password        = each.value.admin_password
    network_interface_ids = [azurerm_network_interface.amanvmnic[each.key].id]
    disable_password_authentication = false
    
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
   
   source_image_reference {
        publisher = each.value.publisher
        offer     = each.value.offer
        sku       = each.value.sku
        version   = each.value.version
    }
}