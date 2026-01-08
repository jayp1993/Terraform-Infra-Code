data "azurerm_key_vault" "kv-data" {
  name                = "mykeyvault"
  resource_group_name = "some-resource-group"
}

resource "azurerm_key_vault_secret" "secret-data" {
  name         = "frontend-vm-username"
  value        = "azureadmin0"
  key_vault_id = azurerm_key_vault.example.id
}
