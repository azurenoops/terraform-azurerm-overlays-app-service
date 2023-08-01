# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

###############
# Outputs    ##
###############

output "app_service_Plan_id" {
  value = azurerm_service_plan.asp.0.id
}

output "app_service_Plan_name" {
  value = azurerm_service_plan.asp.0.name
}

output "app_service_linux_id" {
  value = var.app_service_plan_os_type == "Linux" && var.app_service_resource_type == "App" ? azurerm_linux_web_app.linuxapp.0.id : null
}


