data "azurerm_mssql_server" "mysql-server-data" {
  name                = var.mysql_server_name
  resource_group_name = var.resource_group_name
}