# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#-------------------------------------------------------------
# App Service Custom Hostname Binding
#-------------------------------------------------------------
resource "azurerm_app_service_custom_hostname_binding" "app_service_custom_hostname_binding" {
  for_each = toset(var.custom_domains != null ? keys(var.custom_domains) : [])

  hostname            = each.key
  app_service_name    = azurerm_linux_web_app.app_service_linux.name
  resource_group_name = var.resource_group_name
  ssl_state           = lookup(azurerm_app_service_certificate.app_service_certificate, each.key, null) != null ? "SniEnabled" : null
  thumbprint          = lookup(azurerm_app_service_certificate.app_service_certificate, each.key, null) != null ? azurerm_app_service_certificate.app_service_certificate[each.key].thumbprint : try(data.azurerm_app_service_certificate.certificate[each.key].thumbprint, null)
}