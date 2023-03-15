# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, module.mod_app_service_plan_rg.*.resource_group_name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, module.mod_app_service_plan_rg.*.resource_group_location, [""]), 0)
  app_service_plan_name = coalesce(var.custom_name, data.azurecaf_name.app_service_plan.result)
}
