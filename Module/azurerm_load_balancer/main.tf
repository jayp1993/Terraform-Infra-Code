data "azurerm_public_ip" "lb_ip" {
  name                = "dev-todo-lb-pip"
  resource_group_name ="dev-todo-rg1"
}

resource "azurerm_lb" "azure_lb" {
  name                = "TestLoadBalancer"
  location            = "Central India"
  resource_group_name = "dev-todo-rg1"

  frontend_ip_configuration {
    name                 = "lb-frontend-ip"
    public_ip_address_id = data.azurerm_public_ip.lb_ip.id
  }

}

resource "azurerm_lb_backend_address_pool" "lb-backend-pool" {
  
  loadbalancer_id = azurerm_lb.azure_lb.id
  name            = "lb-BackEndAddressPool"
}

resource "azurerm_lb_probe" "lb-helth-probe" {
  loadbalancer_id = azurerm_lb.azure_lb.id
  name            = "lb-helth-probe"
  port            = 80
}

resource "azurerm_lb_rule" "lb-rule" {
  loadbalancer_id                = azurerm_lb.azure_lb.id
  name                           = "LB-Rule-1"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "lb-frontend-ip"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb-backend-pool.id]
  probe_id = azurerm_lb_probe.lb-helth-probe.id
}


