# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  resource_group_name = element(coalescelist(data.azurerm_resource_group.rg.*.name, module.mod_scaffold_rg.*.resource_group_name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rg.*.location, module.mod_scaffold_rg.*.resource_group_location, [""]), 0)
  app_service_name = coalesce(var.app_service_name, data.azurenoopsutils_resource_name.azurerm_app_service.result)
  app_service_plan_name = "${local.app_service_name}-asp"
  app_user_assigned_identity_name = "${local.app_service_name}-identity"
  app_service_app_insights_name = "${local.app_service_name}-appinsights"
}
