resource "azurerm_windows_web_app" "appService" {
  depends_on = [
    data.azurerm_service_plan.asp,
    azurerm_application_insights.app_service_app_insights,
    data.azurerm_user_assigned_identity.app_identity
  ]
  count               = var.app_service_plan_os_type == "Windows" && var.app_service_resource_type == "App" ? 1 : 0
  name                = local.app_service_name
  resource_group_name = local.resource_group_name
  location            = local.location
  service_plan_id     = data.azurerm_service_plan.asp.id

  key_vault_reference_identity_id = data.azurerm_user_assigned_identity.app_identity.id
  site_config {
    always_on         = true
    health_check_path = var.health_check_path
    use_32_bit_worker = var.use_32_bit_worker
    application_stack {
      current_stack  = var.application_stack
      dotnet_version = var.dotnet_version
    }

  }
  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.app_service_app_insights[0].instrumentation_key
    APPINSIGHTS_CONNECTION_STRING  = azurerm_application_insights.app_service_app_insights[0].connection_string
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      data.azurerm_user_assigned_identity.app_identity.id
    ]
  }
  tags = merge(var.add_tags, local.default_tags)
}

resource "azurerm_windows_web_app_slot" "slot" {
  depends_on = [
    azurerm_windows_web_app.appService
  ]
  count          = var.app_service_plan_os_type == "Windows" && var.app_service_resource_type == "App" ? var.deployment_slot_count : 0
  name           = "${local.app_service_name}-slot-${count.index+1}"
  app_service_id = azurerm_windows_web_app.appService[0].id

  site_config {}
}
