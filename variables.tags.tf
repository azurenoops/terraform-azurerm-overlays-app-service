# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

variable "default_tags_enabled" {
  description = "Option to enable or disable default tags."
  type        = bool
  default     = true
}

variable "add_tags" {
  description = "Map of custom tags."
  type        = map(string)
  default     = {}
}

variable "service_plan_extra_tags" {
  description = "Extra tags to add."
  type        = map(string)
  default     = {}
}