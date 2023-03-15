
output "service_plan_name" {
  value = azurerm_service_plan.plan.name
}

output "service_plan_id" {
  value = azurerm_service_plan.plan.id
}

output "service_plan_resource_group" {
  value = azurerm_service_plan.plan.resource_group_name
}

output "service_plan_location" {
  value = azurerm_service_plan.plan.location
}

output "service_plan_os_type" {
  value = azurerm_service_plan.plan.os_type
}

output "service_plan_sku_name" {
  value = azurerm_service_plan.plan.sku_name
}

output "service_plan_worker_count" {
  value = azurerm_service_plan.plan.worker_count
}

output "service_plan_maximum_elastic_worker_count" {
  value = azurerm_service_plan.plan.maximum_elastic_worker_count
}

output "service_plan_app_service_environment_id" {
  value = azurerm_service_plan.plan.app_service_environment_id
}

output "service_plan_per_site_scaling_enabled" {
  value = azurerm_service_plan.plan.per_site_scaling_enabled
}


