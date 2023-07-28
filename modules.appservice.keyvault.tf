# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

module "mod_key_vault" {
  depends_on = [
    azurerm_user_assigned_identity.app_identity
  ]
  source                       = "azurenoops/overlays-key-vault/azurerm"
  version                      = "~> 1.0"
  count                        = var.create_app_keyvault ? 1 : 0
  existing_resource_group_name = local.resource_group_name
  location                     = local.location
  environment                  = var.environment
  deploy_environment           = var.deploy_environment
  org_name                     = var.org_name
  workload_name                = var.workload_name

  # This is to enable the features of the key vault
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false

  # This is to enable public access to the key vault, since we are using a private endpoint, we will disable it
  public_network_access_enabled = false

  # Once `Purge Protection` has been Enabled it's not possible to Disable it
  # Deleting the Key Vault with `Purge Protection` enabled will schedule the Key Vault to be deleted
  # The default retention period is 90 days, possible values are from 7 to 90 days
  # use `soft_delete_retention_days` to set the retention period
  enable_purge_protection = false
  # soft_delete_retention_days = 90

  # Creating Private Endpoint requires, VNet name to create a Private Endpoint
  # By default this will create a `privatelink.vaultcore.azure.net` DNS zone. if created in commercial cloud
  # To use existing subnet, specify `existing_private_subnet_name` with valid subnet name. 
  # To use existing private DNS zone specify `existing_private_dns_zone` with valid zone name.
  enable_private_endpoint       = var.create_app_keyvault
  virtual_network_name          = data.azurerm_virtual_network.pe_vnet.name  
  existing_private_dns_zone     = var.existing_keyvault_private_dns_zone != null ? var.existing_keyvault_private_dns_zone : null
  existing_private_subnet_name  = data.azurerm_subnet.pe_subnet.name
  
  # Current user should be here to be able to create keys and secrets
  #admin_objects_ids = [
  #  data.azuread_group.admin_group.id
  #]

  # This is to enable resource locks for the key vault. 
  enable_resource_locks = var.enable_resource_locks

  # Tags for Azure Resources
  add_tags = merge(var.add_tags, local.default_tags)
}
