variable "mysql_server_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "mssqldatabase_name" {
    type = string
  
}


variable "collation" {
  type = string
}

variable "license_type" {
  type = string
}

variable "max_size_gb" {
type = number
}

variable "sku_name" {
  type = string
}