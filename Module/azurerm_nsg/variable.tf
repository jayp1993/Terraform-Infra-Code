variable "nsg_name" {
  description = "The name of the Network Security Group."
  type        = string
}

variable "nsg_location" {
  description = "The location/region where the NSG will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the NSG."
  type        = string
}

variable "security_rule_name" {
  description = "The name of the security rule."
  type        = string
}
