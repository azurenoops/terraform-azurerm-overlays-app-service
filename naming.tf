# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

data "azurenoopsutils_resource_name" "app_service_plan" {
  name          = var.stack
  resource_type = "azurerm_app_service_plan"
  prefixes      = [var.org_name, module.mod_azure_region_lookup.location_short]
  suffixes      = compact([var.name_prefix == "" ? null : local.name_prefix, var.deploy_environment, local.name_suffix, var.use_naming ? "" : "appsp"])
  use_slug      = var.use_naming
  clean_input   = true
  separator     = "-"
}
