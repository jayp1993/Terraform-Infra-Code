variable "vnet_name" {
  type = string
}
variable "vnet_location" {
  type=string
}
variable "resource_group_name" {
    type=string
  
}
variable "address_space" {
  type = list(string)
}