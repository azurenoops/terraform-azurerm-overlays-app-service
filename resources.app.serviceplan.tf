# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

resource "azurerm_service_plan" "plan" {
  name = local.app_service_plan_name

  location            = local.location
  resource_group_name = local.resource_group_name

  os_type  = lower(var.app_service_plan_os_type) == "container" ? "Linux" : var.app_service_plan_os_type
  sku_name = var.app_service_plan_sku_name

  worker_count                 = var.app_service_plan_sku_name == "Y1" ? null : var.app_service_plan_worker_count
  maximum_elastic_worker_count = var.maximum_elastic_worker_count

  app_service_environment_id = var.app_service_environment_id
  per_site_scaling_enabled   = var.per_site_scaling_enabled

  tags = merge(local.default_tags, var.add_tags)
}
