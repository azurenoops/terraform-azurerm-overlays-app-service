# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

###############
# Outputs    ##
###############

output "application_insights_id" {
  description = "Id of the Application Insights associated to the App Service"
  value       = try(azurerm_application_insights.app_service_app_insights.id, null)
}

output "application_insights_name" {
  description = "Name of the Application Insights associated to the App Service"
  value       = try(azurerm_application_insights.app_service_app_insights.name, null)
}

output "application_insights_app_id" {
  description = "App id of the Application Insights associated to the App Service"
  value       = try(azurerm_application_insights.app_service_app_insights.app_id, null)
}

output "application_insights_instrumentation_key" {
  description = "Instrumentation key of the Application Insights associated to the App Service"
  value       = try(azurerm_application_insights.app_service_app_insights.instrumentation_key, null)
  sensitive   = true
}

output "application_insights_application_type" {
  description = "Application Type of the Application Insights associated to the App Service"
  value       = try(azurerm_application_insights.app_service_app_insights.application_type, null)
}
