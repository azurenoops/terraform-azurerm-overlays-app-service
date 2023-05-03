resource "azurerm_user_assigned_identity" "app_identity" {
  location            = local.location
  name                = local.app_user_assigned_identity_name
  resource_group_name = local.resource_group_name
}

data "azurerm_user_assigned_identity" "app_identity" {
  depends_on = [
    azurerm_user_assigned_identity.app_identity
  ]
  name = local.app_user_assigned_identity_name
  resource_group_name = local.resource_group_name
}