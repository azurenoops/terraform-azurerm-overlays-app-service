# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.


###########################
# Global Configuration   ##
###########################

variable "location" {
  description = "Azure region in which instance will be hosted"
  type        = string
}

variable "environment" {
  description = "The Terraform backend environment e.g. public or usgovernment"
  type        = string
}

variable "deploy_environment" {
  description = "Name of the workload's environment"
  type        = string
}

variable "workload_name" {
  description = "Name of the workload_name"
  type        = string
}

variable "org_name" {
  description = "Name of the organization"
  type        = string
}

#######################
# RG Configuration   ##
#######################

variable "create_resource_group" {
  description = "Controls if the resource group should be created. If set to false, the resource group name must be provided. Default is false."
  type        = bool
  default     = false
}

variable "use_location_short_name" {
  description = "Use short location name for resources naming (ie eastus -> eus). Default is true. If set to false, the full cli location name will be used. if custom naming is set, this variable will be ignored."
  type        = bool
  default     = true
}

variable "existing_resource_group_name" {
  description = "The name of the existing resource group to use. If not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables."
  type        = string
  default     = null
}

##############################
# App Service Configuration ##
##############################
variable create_app_service_plan {
  description = "Controls if the app service plan should be created. If set to false, the app service plan name must be provided. Default is true."
  type        = bool
  default     = true
}
variable existing_app_service_plan_name {
  description = "Name of the existing app service plan to use"
  type        = string
  default     = null
}
variable app_service_environment {
  description = "The name of the app service environment to deploy to (Optional)"
  type        = string
  default     = null
}
variable app_service_plan_os_type {
  description = "The kind of the app service plan to deploy to (Optional)"
  type        = string
  validation {
    condition = contains(["Linux", "Windows", "WindowsContainer"], var.app_service_plan_os_type)
    error_message = "Must be Windows, Linux, WindowsContainer"
  }
  default = "Windows"
}
variable app_service_resource_type {
  description = "The resource type of the app service plan to deploy to (Optional)"
  type        = string
  validation {
    condition = contains(["App", "FunctionApp"], var.app_service_resource_type)
    error_message = "Must be App, FunctionApp"
  }
  default = "App"
}
variable app_service_name {
  description = "The name of the app service to be deployed, if not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables."
  type        = string
  default     = null
}
variable app_service_plan_sku_name {
  description = "Specifies the SKU for the plan"
  type        = string
  default     = null
}
variable health_check_path {
  description = "Specifies the health check path for the app service"
  type        = string
  default     = null
}
variable application_stack {
  description = "Specifies the application stack for the app service"
  type        = string
  default     = null
}
variable dotnet_version {
  description = "Specifies the dotnet version for the app service"
  type        = string
  default     = null
}
variable dotnet_core_version {
  description = "Specifies the dotnet core version for the app service"
  type        = string
  default     = null
}
variable java_version {
  description = "Specifies the java version for the app service"
  type        = string
  default     = null
}
variable deployment_slot_count {
  description = "Specifies the number of deployment slots for the app service"
  type        = number
  default     = 0
}
variable create_app_storage_account {
  description = "Controls if the storage account should be created. Default is true."
  type        = bool
  default     = true
  }
variable app_storage_account_name {
  description = "Name of an existing storage account to use with the app"
  type        = string
  default     = null
}
#######################################
# KeyVault Configuration              #
#######################################
variable create_app_keyvault {
  description = "Controls if the keyvault should be created. Default is true."
  type        = bool
  default     = true
}
variable virtual_network_name {
  description = "The name of the virtual network to deploy KeyVault to (Optional)"
  type        = string
  default     = null
}
variable private_endpoint_subnet_name {
  description = "The name of the private endpoint subnet to deploy KeyVault to (Optional)"
  type        = string
  default     = null
}
#######################################
# Application Insights Configuration              #
#######################################
variable enable_application_insights {
  description = "Controls if the application insights should be created. Default is true."
  type        = bool
  default     = true
}
variable log_analytics_workspace_id {
  description = "The name of the log analytics workspace to deploy application insights to (Optional)"
  type        = string
  default     = null
}