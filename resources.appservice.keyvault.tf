resource "azurerm_key_vault_access_policy" "app_access_policy" {
  depends_on = [
    module.mod_key_vault,
    azurerm_user_assigned_identity.app_identity
  ]
  key_vault_id = data.azurerm_key_vault.app_key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_user_assigned_identity.app_identity.principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}