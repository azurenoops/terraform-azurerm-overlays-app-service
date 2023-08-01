# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

###############
# Outputs    ##
###############

output "linux_app_service_id" {
  description = "Id of the Linux App Service"
  value       = var.app_service_plan_os_type == "Linux" && var.app_service_resource_type == "App" ? azurerm_linux_web_app.linuxapp.0.id : null
}

output "linux_app_service_name" {
  description = "Name of the Linux App Service"
  value       = var.app_service_plan_os_type == "Linux" && var.app_service_resource_type == "App" ? azurerm_linux_web_app.linuxapp.0.name : null
}

output "linux_app_service_default_site_hostname" {
  description = "The Default Hostname associated with the Linux App Service"
  value       = var.app_service_plan_os_type == "Linux" && var.app_service_resource_type == "App" ? azurerm_linux_web_app.linuxapp.0.default_hostname : null
}

output "linux_app_service_outbound_ip_addresses" {
  description = "Outbound IP adresses of the App Service"
  value       = split(",", azurerm_linux_web_app.linuxapp.0.outbound_ip_addresses)
}

output "linux_app_service_possible_outbound_ip_addresses" {
  description = "Possible outbound IP adresses of the App Service"
  value       = split(",", azurerm_linux_web_app.linuxapp.0.possible_outbound_ip_addresses)
}

output "linux_app_service_site_credential" {
  description = "Site credential block of the App Service"
  value       = azurerm_linux_web_app.linuxapp.0.site_credential
}

output "linux_app_service_identity_service_principal_id" {
  description = "Id of the Service principal identity of the App Service"
  value       = azurerm_linux_web_app.linuxapp.0.identity[0].principal_id
}

output "linux_app_service_slot_name" {
  description = "Name of the App Service slot"
  value       = try(azurerm_linux_web_app_slot.slot[0].name, null)
}

output "linux_app_service_slot_identity_service_principal_id" {
  description = "Id of the Service principal identity of the App Service slot"
  value       = try(azurerm_linux_web_app_slot.slot[0].identity[0].principal_id, null)
}
