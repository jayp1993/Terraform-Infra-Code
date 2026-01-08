variable "subnet_name" {
  description = "The name of the subnet for the Bastion host."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "public_ip_name" {
  description = "The name of the public IP address for the Bastion host."
  type        = string
}

variable "bastion_name" {
  description = "The name of the Bastion host."
  type        = string
  default     = "examplebastion"
}

variable "bastion_location" {
  description = "The Azure region for the Bastion host."
  type        = string
  default     = "Central India"
}
