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

| Name                                                                                        | Version  |
|---------------------------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform)                   | >= 1.3   |
| <a name="requirement_azurenoopsutils"></a> [azurenoopsutils](#requirement\_azurenoopsutils) | ~> 1.0.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)                         | ~> 3.22  |

## Providers

| Name                                                                                  | Version  |
|---------------------------------------------------------------------------------------|----------|
| <a name="provider_azurenoopsutils"></a> [azurenoopsutils](#provider\_azurenoopsutils) | ~> 1.0.4 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm)                         | ~> 3.22  |

## Modules

| Name                                                                                                            | Source                                       | Version  |
|-----------------------------------------------------------------------------------------------------------------|----------------------------------------------|----------|
| <a name="module_mod_azure_region_lookup"></a> [mod\_azure\_region\_lookup](#module\_mod\_azure\_region\_lookup) | azurenoops/overlays-azregions-lookup/azurerm | ~> 1.0.0 |
| <a name="module_mod_key_vault"></a> [mod\_key\_vault](#module\_mod\_key\_vault)                                 | azurenoops/overlays-key-vault/azurerm        | ~> 1.0.0 |
| <a name="module_mod_scaffold_rg"></a> [mod\_scaffold\_rg](#module\_mod\_scaffold\_rg)                           | azurenoops/overlays-resource-group/azurerm   | ~> 1.0.1 |
| <a name="module_overlays-storage-account"></a> [overlays-storage-account](#module\_overlays-storage-account)    | azurenoops/overlays-storage-account/azurerm  | ~> 0.1.0 |

## Resources

| Name                                                                                                                                                           | Type        |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [azurerm_application_insights.app_service_app_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights)  | resource    |
| [azurerm_key_vault_access_policy.app_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy)   | resource    |
| [azurerm_linux_function_app.func](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app)                          | resource    |
| [azurerm_linux_function_app_slot.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app_slot)             | resource    |
| [azurerm_management_lock.resource_group_level_lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock)           | resource    |
| [azurerm_service_plan.asp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan)                                       | resource    |
| [azurerm_user_assigned_identity.app_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity)          | resource    |
| [azurerm_windows_function_app.func](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app)                      | resource    |
| [azurerm_windows_function_app_slot.slot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app_slot)            | resource    |
| [azurerm_windows_web_app.appService](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app)                          | resource    |
| [azurerm_windows_web_app_slot.slot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app_slot)                      | resource    |
| [azurenoopsutils_resource_name.azurerm_app_service](https://registry.terraform.io/providers/azurenoops/azurenoopsutils/latest/docs/data-sources/resource_name) | data source |
| [azurerm_app_service_environment_v3.ase](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/app_service_environment_v3)        | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config)                              | data source |
| [azurerm_key_vault.app_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault)                                | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)                                 | data source |
| [azurerm_service_plan.asp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/service_plan)                                    | data source |
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account)                               | data source |
| [azurerm_subnet.pe_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet)                                          | data source |
| [azurerm_user_assigned_identity.app_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity)       | data source |

## Inputs

| Name                                                                                                                                 | Description                                                                                                                                                                                         | Type          | Default          | Required |
|--------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|------------------|:--------:|
| <a name="input_add_tags"></a> [add\_tags](#input\_add\_tags)                                                                         | Map of custom tags.                                                                                                                                                                                 | `map(string)` | `{}`             |    no    |
| <a name="input_app_service_environment"></a> [app\_service\_environment](#input\_app\_service\_environment)                          | The name of the app service environment to deploy to (Optional)                                                                                                                                     | `string`      | `null`           |    no    |
| <a name="input_app_service_name"></a> [app\_service\_name](#input\_app\_service\_name)                                               | The name of the app service to be deployed, if not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables.                         | `string`      | `null`           |    no    |
| <a name="input_app_service_plan_os_type"></a> [app\_service\_plan\_os\_type](#input\_app\_service\_plan\_os\_type)                   | The kind of the app service plan to deploy to (Optional)                                                                                                                                            | `string`      | `"Windows"`      |    no    |
| <a name="input_app_service_plan_sku_name"></a> [app\_service\_plan\_sku\_name](#input\_app\_service\_plan\_sku\_name)                | Specifies the SKU for the plan                                                                                                                                                                      | `string`      | `null`           |    no    |
| <a name="input_app_service_resource_type"></a> [app\_service\_resource\_type](#input\_app\_service\_resource\_type)                  | The resource type of the app service plan to deploy to (Optional)                                                                                                                                   | `string`      | `"App"`          |    no    |
| <a name="input_app_storage_account_name"></a> [app\_storage\_account\_name](#input\_app\_storage\_account\_name)                     | Name of an existing storage account to use with the app                                                                                                                                             | `string`      | `null`           |    no    |
| <a name="input_application_stack"></a> [application\_stack](#input\_application\_stack)                                              | Specifies the application stack for the app service                                                                                                                                                 | `string`      | `null`           |    no    |
| <a name="input_create_app_keyvault"></a> [create\_app\_keyvault](#input\_create\_app\_keyvault)                                      | Controls if the keyvault should be created. Default is true.                                                                                                                                        | `bool`        | `true`           |    no    |
| <a name="input_create_app_service_plan"></a> [create\_app\_service\_plan](#input\_create\_app\_service\_plan)                        | Controls if the app service plan should be created. If set to false, the app service plan name must be provided. Default is true.                                                                   | `bool`        | `true`           |    no    |
| <a name="input_create_app_storage_account"></a> [create\_app\_storage\_account](#input\_create\_app\_storage\_account)               | Controls if the storage account should be created. Default is true.                                                                                                                                 | `bool`        | `true`           |    no    |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group)                                | Controls if the resource group should be created. If set to false, the resource group name must be provided. Default is false.                                                                      | `bool`        | `false`          |    no    |
| <a name="input_custom_resource_group_name"></a> [custom\_resource\_group\_name](#input\_custom\_resource\_group\_name)               | The name of the custom resource group to create. If not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables.                    | `string`      | `null`           |    no    |
| <a name="input_default_tags_enabled"></a> [default\_tags\_enabled](#input\_default\_tags\_enabled)                                   | Option to enable or disable default tags.                                                                                                                                                           | `bool`        | `true`           |    no    |
| <a name="input_deploy_environment"></a> [deploy\_environment](#input\_deploy\_environment)                                           | Name of the workload's environment                                                                                                                                                                  | `string`      | n/a              |   yes    |
| <a name="input_deployment_slot_count"></a> [deployment\_slot\_count](#input\_deployment\_slot\_count)                                | Specifies the number of deployment slots for the app service                                                                                                                                        | `number`      | `0`              |    no    |
| <a name="input_dotnet_core_version"></a> [dotnet\_core\_version](#input\_dotnet\_core\_version)                                      | Specifies the dotnet core version for the app service                                                                                                                                               | `string`      | `null`           |    no    |
| <a name="input_dotnet_version"></a> [dotnet\_version](#input\_dotnet\_version)                                                       | Specifies the dotnet version for the app service                                                                                                                                                    | `string`      | `null`           |    no    |
| <a name="input_enable_application_insights"></a> [enable\_application\_insights](#input\_enable\_application\_insights)              | Controls if the application insights should be created. Default is true.                                                                                                                            | `bool`        | `true`           |    no    |
| <a name="input_enable_resource_locks"></a> [enable\_resource\_locks](#input\_enable\_resource\_locks)                                | (Optional) Enable resource locks, default is false. If true, resource locks will be created for the resource group and the storage account.                                                         | `bool`        | `false`          |    no    |
| <a name="input_environment"></a> [environment](#input\_environment)                                                                  | The Terraform backend environment e.g. public or usgovernment                                                                                                                                       | `string`      | n/a              |   yes    |
| <a name="input_existing_app_service_plan_name"></a> [existing\_app\_service\_plan\_name](#input\_existing\_app\_service\_plan\_name) | Name of the existing app service plan to use                                                                                                                                                        | `string`      | `null`           |    no    |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name)         | The name of the existing resource group to use. If not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables.                     | `string`      | `null`           |    no    |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path)                                            | Specifies the health check path for the app service                                                                                                                                                 | `string`      | `null`           |    no    |
| <a name="input_java_version"></a> [java\_version](#input\_java\_version)                                                             | Specifies the java version for the app service                                                                                                                                                      | `string`      | `null`           |    no    |
| <a name="input_location"></a> [location](#input\_location)                                                                           | Azure region in which instance will be hosted                                                                                                                                                       | `string`      | n/a              |   yes    |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level)                                                                   | (Optional) id locks are enabled, Specifies the Level to be used for this Lock.                                                                                                                      | `string`      | `"CanNotDelete"` |    no    |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id)               | The name of the log analytics workspace to deploy application insights to (Optional)                                                                                                                | `string`      | `null`           |    no    |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix)                                                                | Optional prefix for the generated name                                                                                                                                                              | `string`      | `""`             |    no    |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix)                                                                | Optional suffix for the generated name                                                                                                                                                              | `string`      | `""`             |    no    |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name)                                                                         | Name of the organization                                                                                                                                                                            | `string`      | n/a              |   yes    |
| <a name="input_private_endpoint_subnet_name"></a> [private\_endpoint\_subnet\_name](#input\_private\_endpoint\_subnet\_name)         | The name of the private endpoint subnet to deploy KeyVault to (Optional)                                                                                                                            | `string`      | `null`           |    no    |
| <a name="input_use_32_bit_worker"></a> [use\_32\_bit\_worker](#input\_use\_32\_bit\_worker)                                          | Use 32 bit worker for the app service                                                                                                                                                               | `bool`        | `false`          |    no    |
| <a name="input_use_location_short_name"></a> [use\_location\_short\_name](#input\_use\_location\_short\_name)                        | Use short location name for resources naming (ie eastus -> eus). Default is true. If set to false, the full cli location name will be used. if custom naming is set, this variable will be ignored. | `bool`        | `true`           |    no    |
| <a name="input_use_naming"></a> [use\_naming](#input\_use\_naming)                                                                   | Use the Azure NoOps naming provider to generate default resource name. `storage_account_custom_name` override this if set. Legacy default name is used if this is set to `false`.                   | `bool`        | `true`           |    no    |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name)                                   | The name of the virtual network to deploy KeyVault to (Optional)                                                                                                                                    | `string`      | `null`           |    no    |
| <a name="input_workload_name"></a> [workload\_name](#input\_workload\_name)                                                          | Name of the workload\_name                                                                                                                                                                          | `string`      | n/a              |   yes    |

## Outputs

No outputs.
<!-- END_TF_DOCS -->