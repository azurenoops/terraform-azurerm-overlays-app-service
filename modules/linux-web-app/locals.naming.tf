# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, module.mod_key_vault_rg.*.resource_group_name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, module.mod_key_vault_rg.*.resource_group_location, [""]), 0)
  app_service_name  = coalesce(var.app_service_custom_name, data.azurecaf_name.app_service_web.result)
  staging_slot_name = coalesce(var.staging_slot_custom_name, "staging-slot")

  app_insights_name = coalesce(var.application_insights_custom_name, data.azurecaf_name.application_insights.result)

  backup_name = coalesce(var.backup_custom_name, "DefaultBackup")
}
