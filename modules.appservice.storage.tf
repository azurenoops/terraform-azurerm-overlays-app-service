module "overlays-storage-account" {
  source                       = "azurenoops/overlays-storage-account/azurerm"
  version                      = ">= 0.1.0"
  count                        = var.create_app_storage_account && var.app_storage_account_name == null ? 1 : 0
  location                     = local.location
  existing_resource_group_name = local.resource_group_name
  environment                  = var.environment
  deploy_environment           = var.deploy_environment
  workload_name                = var.workload_name
  org_name                     = var.org_name
  virtual_network_name         = var.virtual_network_name
  existing_subnet_id           = data.azurerm_subnet.pe_subnet.address_prefixes[0]
}
