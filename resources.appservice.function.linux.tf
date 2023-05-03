resource "azurerm_linux_function_app" "func" {
depends_on = [
    azurerm_service_plan.asp,
    azurerm_application_insights.app_service_app_insights,
    module.overlays-storage-account
  ]
  count               = var.app_service_plan_os_type == "Linux" && var.app_service_resource_type == "FunctionApp" ? 1 : 0
  name                = local.app_service_name
  resource_group_name = local.resource_group_name
  location            = local.location

  storage_account_name       = module.overlays-storage-account.0.storage_account_name
  storage_account_access_key = data.azurerm_storage_account.sa.primary_access_key
  service_plan_id            = data.azurerm_service_plan.asp.id

  key_vault_reference_identity_id = data.azurerm_user_assigned_identity.app_identity.id
  site_config {
    always_on         = true
    health_check_path = var.health_check_path
    use_32_bit_worker = var.use_32_bit_worker
    application_stack {
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
resource "azurerm_linux_function_app_slot" "example" {
  depends_on = [
    azurerm_linux_function_app.func
  ]
  count           = var.app_service_plan_os_type == "Linux" && var.app_service_resource_type == "FunctionApp" ? var.deployment_slot_count : 0
  name            = "${local.app_service_name}-slot-${count.index + 1}"
  function_app_id = azurerm_linux_function_app.func[0].id
  storage_account_name = module.overlays-storage-account.0.storage_account_name

  site_config {}
}