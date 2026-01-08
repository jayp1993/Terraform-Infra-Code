module "dev-todo-rg" {
  source      = "../../Module/azurerm_resource_group"
  rg_name     ="dev-todo-rg1"
  rg_location = "Central India"
}

module "lb-vnet" {
  depends_on = [ module.dev-todo-rg ]
  source = "../../Module/azurerm_azure_network"
  vnet_name          = "dev-todo-vnet1"
  vnet_location      = "Central India"
  resource_group_name = "dev-todo-rg1"
  address_space     = ["10.10.10.0/24"]
}
module "lb-subnet" {
  depends_on = [ module.lb-vnet ]
  source = "../../Module/azurerm_subnet"
  subnet_name         = "dev-todo-subnet1"
  resource_group_name  = "dev-todo-rg1"
  virtual_network_name = "dev-todo-vnet1"
  address_prefixes     = ["10.10.10.0/25"]
}

module "bastion-subnet" {
  depends_on = [ module.lb-vnet ]
  source = "../../Module/azurerm_subnet"
  subnet_name         = "AzureBastionSubnet"
  resource_group_name  = "dev-todo-rg1"
  virtual_network_name = "dev-todo-vnet1"
  address_prefixes     = ["10.10.10.128/26"]
}

module "todo_linux_vm01" {
  depends_on = [ module.lb-vnet,module.lb-subnet ]
  source = "../../Module/azurerm_Linux_virtual_machine"
  subnet_name           = "dev-todo-subnet1"
  vnet_name             = "dev-todo-vnet1"
  todo_nic_name        = "dev-todo-nic1"
  location             = "Central India"
  resource_resouce_group = "dev-todo-rg1"
  ip_configuration_name = "dev-todo-ipconfig1"
  todo_linux_vm_name    = "dev-todo-linux-vm1"
  vm_size               = "Standard_D2s_v3"
  publisher            = "Canonical"
  offer                = "UbuntuServer"
  sku                  = "18.04-LTS"
}

module "todo_linux_vm02" {
   depends_on = [ module.lb-vnet,module.lb-subnet ]
  source = "../../Module/azurerm_Linux_virtual_machine"
  subnet_name           = "dev-todo-subnet1"
  vnet_name             = "dev-todo-vnet1"
  todo_nic_name        = "dev-todo-nic2"
  location             = "Central India"
  resource_resouce_group = "dev-todo-rg1"
  ip_configuration_name = "dev-todo-ipconfig2"
  todo_linux_vm_name    = "dev-todo-linux-vm2"
  vm_size               = "Standard_D2s_v3"
  publisher            = "Canonical"
  offer                = "UbuntuServer"
  sku                  = "18.04-LTS"
}

module "lb-ip" {
  source = "../../Module/azurerm_pip"
  pip_name            = "dev-todo-lb-pip"
  resource_group_name = "dev-todo-rg1"
  location            = "Central India"
  allocation_method   = "Static"
}

module "bastion-ip" {
  source = "../../Module/azurerm_pip"
  pip_name            = "dev-todo-bastion-pip"
  resource_group_name = "dev-todo-rg1"
  location            = "Central India"
  allocation_method   = "Static"
}

module "lb" {
  depends_on = [ module.lb-ip ]
  source = "../../Module/azurerm_load_balancer"
}

module "nic-lb-backend-associan" {
  depends_on = [ module.todo_linux_vm01, module.lb ]
  source = "../../Module/azurerm_nic_lb_pool_association"
  network_interface_name = "dev-todo-nic1"
  resource_group_name = "dev-todo-rg1"
  load_balancer_name = "TestLoadBalancer"
  backend_address_pool_name = "lb-BackEndAddressPool"
  ip_configuration_name = "dev-todo-ipconfig1"
}

module "nic-lb-backend-associan1" {
  depends_on = [ module.lb, module.todo_linux_vm02 ]
  source = "../../Module/azurerm_nic_lb_pool_association"
  network_interface_name = "dev-todo-nic2"
  resource_group_name = "dev-todo-rg1"
  load_balancer_name = "TestLoadBalancer"
  backend_address_pool_name = "lb-BackEndAddressPool"
  ip_configuration_name = "dev-todo-ipconfig2"
}

module "dev_nsg_associan" {
  source              = "../../Module/azurerm_nsg_associan"
  nsg_name            = "dev-todo-nsg1"
  resource_group_name = "dev-todo-rg1"
  subnet_name         = "dev-todo-subnet1"
  vnet_name           = "dev-todo-vnet1"
}

module "dev_nsg" {
  source               = "../../Module/azurerm_nsg"
  nsg_name             = "dev-todo-nsg1"
  nsg_location         = "Central India"
  resource_group_name  = "dev-todo-rg1"
  security_rule_name   = "AllowAllInbound"
}

module "dev_bastion" {
  depends_on = [ module.bastion-subnet, module.bastion-ip]
  source              = "../../Module/azurerm_bastion"
  subnet_name         = "AzureBastionSubnet"
  vnet_name           = "dev-todo-vnet1"
  resource_group_name = "dev-todo-rg1"
  public_ip_name      = "dev-todo-bastion-pip"
  bastion_name        = "dev-todo-bastion"
  bastion_location    = "Central India"
}


