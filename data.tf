# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# remove file if not needed
data "azurerm_client_config" "current" {}
data "azurerm_app_service_environment_v3" "ase" {
  count               = var.app_service_environment == null ? 0 : 1
  name                = var.app_service_environment
  resource_group_name = local.resource_group_name
}
data "azurerm_subnet" "pe_subnet" {
  depends_on = [
  module.mod_scaffold_rg]
  name                 = var.private_endpoint_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = local.resource_group_name
}

data "azurerm_service_plan" "asp" {
  depends_on = [
    azurerm_service_plan.asp
  ]
  name                = local.app_service_plan_name
  resource_group_name = local.resource_group_name
}
data "azurerm_key_vault" "app_key_vault" {
depends_on = [
    module.mod_scaffold_rg,
    module.mod_key_vault]
  name                = module.mod_key_vault.0.key_vault_name
  resource_group_name = local.resource_group_name
}

data "azurerm_storage_account" "sa" {
  depends_on = [ 
    module.overlays-storage-account
   ]
  name                = module.overlays-storage-account.0.storage_account_name
  resource_group_name = local.resource_group_name
}