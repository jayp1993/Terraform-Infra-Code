data "azurerm_subnet" "bastion_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_public_ip" "bastion_public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_name
  location            = var.bastion_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.bastion_subnet.id
    public_ip_address_id = data.azurerm_public_ip.bastion_public_ip.id
  }
}

