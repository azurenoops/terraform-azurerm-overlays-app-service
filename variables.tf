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
variable "create_app_service_plan" {
  description = "Controls if the app service plan should be created. If set to false, the app service plan name must be provided. Default is true."
  type        = bool
  default     = true
}
variable "existing_app_service_plan_name" {
  description = "Name of the existing app service plan to use"
  type        = string
  default     = null
}
variable "app_service_environment" {
  description = "The name of the app service environment to deploy to (Optional)"
  type        = string
  default     = null
}
variable "app_service_plan_os_type" {
  description = "The kind of the app service plan to deploy to (Optional)"
  type        = string
  validation {
    condition     = contains(["Linux", "Windows", "WindowsContainer"], var.app_service_plan_os_type)
    error_message = "Must be Windows, Linux, WindowsContainer"
  }
  default = "Windows"
}
variable "app_service_resource_type" {
  description = "The resource type of the app service plan to deploy to (Optional)"
  type        = string
  validation {
    condition     = contains(["App", "FunctionApp"], var.app_service_resource_type)
    error_message = "Must be App, FunctionApp"
  }
  default = "App"
}
variable "app_service_name" {
  description = "The name of the app service to be deployed, if not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables."
  type        = string
  default     = null
}
variable "app_service_plan_sku_name" {
  description = "Specifies the SKU for the plan"
  type        = string
  default     = null
}
variable "health_check_path" {
  description = "Specifies the health check path for the app service"
  type        = string
  default     = null
}
variable "application_stack" {
  description = "Specifies the application stack for the app service"
  type        = string
  default     = null
}
variable "dotnet_version" {
  description = "Specifies the dotnet version for the app service"
  type        = string
  default     = null
}
variable "dotnet_core_version" {
  description = "Specifies the dotnet core version for the app service"
  type        = string
  default     = null
}
variable "java_version" {
  description = "Specifies the java version for the app service"
  type        = string
  default     = null
}
variable "deployment_slot_count" {
  description = "Specifies the number of deployment slots for the app service"
  type        = number
  default     = 0
}
variable "create_app_storage_account" {
  description = "Controls if the storage account should be created. Default is true."
  type        = bool
  default     = true
}
variable "app_storage_account_name" {
  description = "Name of an existing storage account to use with the app"
  type        = string
  default     = null
}
variable "use_32_bit_worker" {
  description = "Use 32 bit worker for the app service"
  type        = bool
  default     = false
}
variable "windows_app_site_config" {
  type = object({
    always_on             = optional(bool)
    api_definition_url    = optional(string)
    api_management_api_id = optional(string)
    app_command_line      = optional(string)
    application_stack = optional(object({
      current_stack                = optional(string)
      docker_container_name        = optional(string)
      docker_container_registry    = optional(string)
      docker_container_tag         = optional(string)
      dotnet_version               = optional(string)
      dotnet_core_version          = optional(string)
      tomcat_version               = optional(string)
      java_embedded_server_enabled = optional(bool)
      java_version                 = optional(string)
      node_version                 = optional(string)
      php_version                  = optional(string)
      python                       = optional(bool)
    }))
    auto_heal_enabled = optional(bool)
    auto_heal_setting = optional(object({
      action = object({
        action_type = string
        custom_action = optional(object({
          executable = string
          parameters = string
        }))
        minimum_process_execution_time = optional(string)
      })
      trigger = object({
        private_memory_kb = optional(number)
        requests = optional(object({
          count    = number
          interval = string
        }))
        slow_request = list(object({
          count      = number
          interval   = string
          time_taken = string
          path       = optional(string)
        }))
        status_code = list(object({
          count             = number
          interval          = string
          status_code_range = string
          path              = optional(string)
          sub_status        = optional(string)
          win32_status      = optional(string)
        }))
      })
    }))
    container_registry_managed_identity_client_id = optional(string)
    container_registry_use_managed_identity       = optional(bool)
    cors = optional(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool)
    }))
    default_documents                 = optional(list(string))
    ftps_state                        = optional(string)
    health_check_path                 = optional(string)
    health_check_eviction_time_in_min = optional(number)
    http2_enabled                     = optional(bool)
    ip_restriction = optional(list(object({
      action = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(number)
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })))
    load_balancing_mode      = optional(string)
    local_mysql_enabled      = optional(bool)
    managed_pipeline_mode    = optional(string)
    minimum_tls_version      = optional(string)
    remote_debugging_enabled = optional(bool)
    remote_debugging_version = optional(string)
    scm_ip_restriction = optional(list(object({
      action = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(number)
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })))
    scm_minimum_tls_version     = optional(string)
    scm_use_main_ip_restriction = optional(bool)
    use_32_bit_worker           = optional(bool)
    virtual_application = optional(list(object({
      physical_path = string
      preload       = bool
      virtual_path  = string
      virtual_directory = optional(object({
        physical_path = optional(string)
        virtual_path  = optional(string)
      }))
    })))
    vnet_route_all_enabled = optional(bool)
    websockets_enabled     = optional(bool)
    worker_count           = optional(number)
  })
  default = null
}
variable "windows_function_app_site_config" {
  type = object({
    always_on                              = optional(bool)
    api_definition_url                     = optional(string)
    api_management_api_id                  = optional(string)
    app_command_line                       = optional(string)
    app_scale_limit                        = optional(number)
    application_insights_connection_string = optional(string)
    application_insights_key               = optional(string)
    application_stack = optional(object({
      dotnet_version              = optional(string)
      use_dotnet_isolated_runtime = optional(bool)
      java_version                = optional(string)
      node_version                = optional(string)
      powershell_core_version     = optional(string)
      use_custom_runtime          = optional(bool)
    }))
    app_service_logs = optional(object({
      disk_quota_mb         = optional(number)
      retention_period_days = optional(number)
    }))
    cors = optional(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool)
    }))
    default_documents                 = optional(list(string))
    elastic_instance_minimum          = optional(number)
    ftps_state                        = optional(string)
    health_check_path                 = optional(string)
    health_check_eviction_time_in_min = optional(number)
    http2_enabled                     = optional(bool)
    ip_restriction = optional(list(object({
      action = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(number)
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })))
    load_balancing_mode               = optional(string)
    managed_pipeline_mode             = optional(string)
    minimum_tls_version               = optional(string)
    pre_warmed_instance_count         = optional(number)
    remote_debugging_enabled          = optional(bool)
    remote_debugging_version          = optional(string)
    runtime_scale_moniitoring_enabled = optional(bool)
    scm_ip_restriction = optional(list(object({
      action = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(number)
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })))
    scm_minimum_tls_version     = optional(string)
    scm_use_main_ip_restriction = optional(bool)
    use_32_bit_worker           = optional(bool)
    virtual_application = optional(list(object({
      physical_path = string
      preload       = bool
      virtual_path  = string
      virtual_directory = optional(object({
        physical_path = optional(string)
        virtual_path  = optional(string)
      }))
    })))
    vnet_route_all_enabled = optional(bool)
    websockets_enabled     = optional(bool)
    worker_count           = optional(number)
  })
  default = null
}
variable "linux_app_site_config" {
  type = object({
    always_on             = optional(bool)
    api_definition_url    = optional(string)
    api_management_api_id = optional(string)
    app_command_line      = optional(string)
    application_stack = optional(object({
      docker_image        = optional(string)
      docker_image_tag    = optional(string)
      dotnet_version      = optional(string)
      go_version          = optional(string)
      java_server         = optional(string)
      java_server_version = optional(string)
      java_version        = optional(string)
      node_version        = optional(string)
      php_version         = optional(string)
      python_version      = optional(string)
      ruby_version        = optional(string)
    }))
    container_registry_managed_identity_client_id = optional(string)
    container_registry_use_managed_identity       = optional(bool)
    cors = optional(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool)
    }))
    default_documents                 = optional(list(string))
    ftps_state                        = optional(string)
    health_check_path                 = optional(string)
    health_check_eviction_time_in_min = optional(number)
    http2_enabled                     = optional(bool)
    ip_restriction = optional(list(object({
      action = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(number)
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })))
    load_balancing_mode      = optional(string)
    local_mysql_enabled      = optional(bool)
    managed_pipeline_mode    = optional(string)
    minimum_tls_version      = optional(string)
    remote_debugging_enabled = optional(bool)
    remote_debugging_version = optional(string)
    scm_ip_restriction = optional(list(object({
      action = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(number)
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })))
    scm_minimum_tls_version     = optional(string)
    scm_use_main_ip_restriction = optional(bool)
    use_32_bit_worker           = optional(bool)
    vnet_route_all_enabled      = optional(bool)
    websockets_enabled          = optional(bool)
    worker_count                = optional(number)
  })
  default = null
}
variable "linux_function_app_site_config" {
  type = object({
    always_on                              = optional(bool)
    api_definition_url                     = optional(string)
    api_management_api_id                  = optional(string)
    app_command_line                       = optional(string)
    app_scale_limit                        = optional(number)
    application_insights_connection_string = optional(string)
    application_insights_key               = optional(string)
    application_stack = optional(object({
      docker = optional(object({
        registry_url      = string
        image_name        = string
        image_tag         = string
        registry_username = optional(string)
      }))
      dotnet_version              = optional(string)
      use_dotnet_isolated_runtime = optional(bool)
      java_version                = optional(string)
      node_version                = optional(string)
      python_version              = optional(string)
      powershell_core_version     = optional(string)
      use_custom_runtime          = optional(bool)
    }))
    app_service_logs = optional(object({
      disk_quota_mb         = optional(number)
      retention_period_days = optional(number)
    }))
    container_registry_managed_identity_client_id = optional(string)
    container_registry_use_managed_identity       = optional(bool)
    cors = optional(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool)
    }))
    default_documents                 = optional(list(string))
    elastic_instance_minimum          = optional(number)
    ftps_state                        = optional(string)
    health_check_path                 = optional(string)
    health_check_eviction_time_in_min = optional(number)
    http2_enabled                     = optional(bool)
    ip_restriction = optional(list(object({
      action = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(number)
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })))
    load_balancing_mode               = optional(string)
    managed_pipeline_mode             = optional(string)
    minimum_tls_version               = optional(string)
    pre_warmed_instance_count         = optional(number)
    remote_debugging_enabled          = optional(bool)
    remote_debugging_version          = optional(string)
    runtime_scale_moniitoring_enabled = optional(bool)
    scm_ip_restriction = optional(list(object({
      action = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(number)
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })))
    scm_minimum_tls_version     = optional(string)
    scm_use_main_ip_restriction = optional(bool)
    use_32_bit_worker           = optional(bool)
    vnet_route_all_enabled      = optional(bool)
    websockets_enabled          = optional(bool)
    worker_count                = optional(number)
  })
  default = null
}
#######################################
# KeyVault Configuration              #
#######################################
variable "create_app_keyvault" {
  description = "Controls if the keyvault should be created. Default is true."
  type        = bool
  default     = true
}
variable "virtual_network_name" {
  description = "The name of the virtual network to deploy KeyVault to (Optional)"
  type        = string
  default     = null
}
variable "private_endpoint_subnet_name" {
  description = "The name of the private endpoint subnet to deploy KeyVault to (Optional)"
  type        = string
  default     = null
}

variable "enable_private_endpoint" {
  description = "Controls if the private endpoint should be created. Default is false."
  type        = bool
  default     = false
}

variable "existing_private_dns_zone" {
  description = "The id of the existing dns zone to use. If not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables."
  type        = string
  default     = null
}

#######################################
# Application Insights Configuration  #
#######################################
variable "enable_application_insights" {
  description = "Controls if the application insights should be created. Default is true."
  type        = bool
  default     = true
}
variable "log_analytics_workspace_id" {
  description = "The name of the log analytics workspace to deploy application insights to (Optional)"
  type        = string
  default     = null
}
