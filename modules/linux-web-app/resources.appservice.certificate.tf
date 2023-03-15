# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#-------------------------------------------------------------
# App Service Certificate
#-------------------------------------------------------------
resource "azurerm_app_service_certificate" "app_service_certificate" {
  for_each = var.custom_domains != null ? {
    for k, v in var.custom_domains :
    k => v if try(v.certificate_id == null, false)
  } : {}

  name                = each.value.certificate_file != null ? basename(each.value.certificate_file) : split("/", each.value.certificate_keyvault_certificate_id)[4]
  resource_group_name = var.resource_group_name
  location            = var.location
  pfx_blob            = each.value.certificate_file != null ? filebase64(each.value.certificate_file) : null
  password            = each.value.certificate_password
  key_vault_secret_id = each.value.certificate_keyvault_certificate_id
}