# Azure App Service Web (Linux or Windows) Overlay Terraform Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![MIT License](https://img.shields.io/badge/license-MIT-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/azurenoops/overlays-key-vault/azurerm/)

This Terraform Module creates a an Azure Service Plan using our dedicated Terraform module and creates an Azure App Service Web (Linux or Windows) associated with an Application Insights component. This also enables private endpoint. This module can be used with an [SCCA compliant Network](https://registry.terraform.io/modules/azurenoops/overlays-hubspoke/azurerm/latest).

## SCCA Compliance

This module can be SCCA compliant and can be used in a SCCA compliant Network. Enable private endpoints and SCCA compliant network rules to make it SCCA compliant.

For more information, please read the [SCCA documentation]("https://www.cisa.gov/secure-cloud-computing-architecture").

## Contributing

If you want to contribute to this repository, feel free to to contribute to our Terraform module.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Resources Used

* [Azure App Service Plan](https://www.terraform.io/docs/providers/azurerm/r/app_service_plan.html)
* [Azure App Service Web (Linux or Windows)](https://www.terraform.io/docs/providers/azurerm/r/app_service.html)
* [Azure Application Insights](https://www.terraform.io/docs/providers/azurerm/r/application_insights.html)
* [Azure App Service Slot](https://www.terraform.io/docs/providers/azurerm/r/app_service_slot.html)
* [Private Endpoints](https://www.terraform.io/docs/providers/azurerm/r/private_endpoint.html)
* [Private DNS zone for `privatelink` A records](https://www.terraform.io/docs/providers/azurerm/r/private_dns_zone.html)
* [Azure Reource Locks](https://www.terraform.io/docs/providers/azurerm/r/management_lock.html)

## Overlay Module Usage

```terraform
# Azurerm Provider configuration
provider "azurerm" {
  features {}
}

module "mod_app_service" {
  source  = "azurenoops/overlays-app-service/azurerm"
  version = "x.x.x"

  # By default, this module will create a resource group and 
  # provide a name for an existing resource group. If you wish 
  # to use an existing resource group, change the option 
  # to "create_app_service_resource_group = false." The location of the group 
  # will remain the same if you use the current resource.
  create_app_service_resource_group = true
  location                        = module.mod_azure_region_lookup.location_cli
  environment                     = "public"
  deploy_environment              = "dev"
  org_name                        = "anoa"
  workload_name                   = "kv"

  # This is to enable the features of the key vault
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false

  # This is to enable public access to the key vault, since we are using a private endpoint, we will disable it
  public_network_access_enabled = false
  
  # Creating Private Endpoint requires, VNet name to create a Private Endpoint
  # By default this will create a `privatelink.azurecr.io` DNS zone. if created in commercial cloud
  # To use existing subnet, specify `existing_subnet_id` with valid subnet id. 
  # To use existing private DNS zone specify `existing_private_dns_zone` with valid zone name
  # Private endpoints doesn't work If not using `existing_subnet_id` to create redis inside a specified VNet.
  enable_private_endpoint = false
  # existing_subnet_id      = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rg-anoa-dev-kv/providers/Microsoft.Network/virtualNetworks/vnet-anoa-dev-kv/subnets/snet-anoa-dev-kv"
  # virtual_network_name    = "vnet-anoa-dev-kv"
  # existing_private_dns_zone     = "demo.example.com"

  # Current user should be here to be able to create keys and secrets
  admin_objects_ids = [
    data.azuread_group.admin_group.id
  ]
  
  # This is to enable resource locks for the key vault. 
  enable_resource_locks = false

  # Tags for Azure Resources
  add_tags = {
    example = "basic deployment of key vault"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

<!-- END_TF_DOCS -->