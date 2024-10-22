variable "consents" {
  type = list(object({
    name            = string
    consent_type    = string
    scopes          = optional(list(string))
    required_fields = optional(list(string))
    consent_versions = list(object({
      version = number
      consent_locales = list(object({
        content = optional(string)
        locale  = string
        url     = optional(string)
      }))
    }))
  }))
  description = "List of consents each containing multiple consent versions and locales"
}

variable "group_name" {
  type        = string
  description = "Name of the consent group"
}

variable "description" {
  type        = string
  default     = null
  description = "Description for the consent group"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Flag to enable or disable a consent"
}