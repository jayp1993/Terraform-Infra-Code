variable "network_interface_name" {
  description = "The name of the network interface."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "load_balancer_name" {
  description = "The name of the load balancer."
  type        = string
}

variable "backend_address_pool_name" {
  description = "The name of the backend address pool."
  type        = string
}

variable "ip_configuration_name" {
  description = "The name of the IP configuration on the NIC."
  type        = string
}