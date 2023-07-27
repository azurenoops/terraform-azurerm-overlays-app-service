
#######################################
# KeyVault Configuration              #
#######################################

variable "create_app_keyvault" {
  description = "Controls if the keyvault should be created. Default is true."
  type        = bool
  default     = true
}

variable "enable_keyvault_private_endpoint" {
  description = "Controls if the private endpoint should be created for Key Vault. Default is false."
  type        = bool
  default     = false
}

variable "existing_keyvault_private_dns_zone" {
  description = "Name of an existing private DNS zone to use with the key vault"
  type        = string
  default     = null
}