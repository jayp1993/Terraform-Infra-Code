# Example: Assign RBAC role to current user
# Get current client details (jo terraform run kar raha hai)
data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "kv-data" {
  name                = "mykeyvault"
  resource_group_name = "some-resource-group"
}
resource "azurerm_role_assignment" "kv_admin_access" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"  # or Key Vault Secrets Officer / Reader
  principal_id         = data.azurerm_client_config.current.object_id
}