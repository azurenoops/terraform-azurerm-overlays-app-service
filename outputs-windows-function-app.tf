# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

###############
# Outputs    ##
###############

output "windows_function_app_service_id" {
  description = "Id of the Linux App Service"
  value       = try(azurerm_windows_function_app.func.0.id, null)
}

output "windows_function_app_service_name" {
  description = "Name of the Linux App Service"
  value       = try(azurerm_windows_function_app.func.0.name, null)
}

output "windows_function_app_service_default_site_hostname" {
  description = "The Default Hostname associated with the Linux App Service"
  value       = try(azurerm_windows_function_app.func.0.default_hostname, null)
}

output "windows_function_app_service_outbound_ip_addresses" {
  description = "Outbound IP addresses of the App Service"
  value       = try(split(",", azurerm_windows_function_app.func.0.outbound_ip_addresses), null)
}

output "windows_function_app_service_possible_outbound_ip_addresses" {
  description = "Possible outbound IP addresses of the App Service"
  value       = try(split(",", azurerm_windows_function_app.func.0.possible_outbound_ip_addresses), null)
}

output "windows_function_app_service_site_credential" {
  description = "Site credential block of the App Service"
  value       = try(azurerm_windows_function_app.func.0.site_credential, null)
}

output "windows_function_app_service_identity_service_principal_id" {
  description = "Id of the Service principal identity of the App Service"
  value       = try(azurerm_windows_function_app.func.0.identity[0].principal_id, null)
}

output "windows_function_app_service_slot_name" {
  description = "Name of the App Service slot"
  value       = try(azurerm_windows_web_app_slot.slot[0].name, null)
}

output "windows_function_app_service_slot_identity_service_principal_id" {
  description = "Id of the Service principal identity of the App Service slot"
  value       = try(azurerm_windows_web_app_slot.slot[0].identity[0].principal_id, null)
}
