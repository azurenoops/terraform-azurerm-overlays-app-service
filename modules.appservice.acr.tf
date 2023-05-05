module "mod_container_registry" {
  source                       = "azurenoops/overlays-container-registry/azurerm"
  version                      = "~> 1.0.0"
  count                        = var.create_app_container_registry ? 1 : 0
  existing_resource_group_name = local.resource_group_name
  location                     = local.location
  environment                  = var.environment
  deploy_environment           = var.deploy_environment
  org_name                     = var.org_name
  workload_name                = var.workload_name
  sku                          = var.acr_sku

  enable_private_endpoint       = var.acr_enable_private_endpoint
  virtual_network_name          = var.virtual_network_name
  private_subnet_address_prefix = data.azurerm_subnet.pe_subnet.address_prefixes[0]
  existing_private_dns_zone     = var.acr_existing_private_dns_zone
  existing_private_subnet_name  = var.private_endpoint_subnet_name 
  public_network_access_enabled = var.acr_public_network_access_enabled
}
