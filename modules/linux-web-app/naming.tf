# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

data "azurenoopsutils_resource_name" "keyvault" {
  name          = var.workload_name
  resource_type = "azurerm_app_service"
  prefixes      = [var.org_name, module.mod_azure_region_lookup.location_short]
  suffixes      = compact([var.name_prefix == "" ? null : local.name_prefix, var.deploy_environment, local.name_suffix, var.use_naming ? "" : "web"])
  use_slug      = var.use_naming
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "application_insights" {
   name          = var.workload_name
  resource_type = "azurerm_application_insights"
  prefixes      = [var.org_name, module.mod_azure_region_lookup.location_short]
  suffixes      = compact([var.name_prefix == "" ? null : local.name_prefix, var.deploy_environment, local.name_suffix, var.use_naming ? "" : "ai"])
  use_slug      = var.use_naming
  clean_input   = true
  separator     = "-"
}