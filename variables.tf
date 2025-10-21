variable "config" {
  description = "Contains all firewall policy configuration"
  type = object({
    name                              = string
    resource_group_name               = optional(string)
    location                          = optional(string)
    private_ip_ranges                 = optional(list(string))
    sku                               = optional(string, "Standard")
    sql_redirect_allowed              = optional(bool)
    threat_intelligence_mode          = optional(string, "Alert")
    base_policy_id                    = optional(string)
    auto_learn_private_ranges_enabled = optional(bool)
    tags                              = optional(map(string))
    key_vault_id                      = optional(string)
    principal_id                      = optional(string)
    dns = optional(object({
      proxy_enabled = optional(bool, false)
      servers       = optional(list(string), [])
    }))
    intrusion_detection = optional(object({
      mode           = optional(string)
      private_ranges = optional(list(string))
      traffic_bypass = optional(map(object({
        protocol              = string
        description           = optional(string)
        destination_addresses = optional(list(string), [])
        destination_ip_groups = optional(list(string), [])
        destination_ports     = optional(list(string), [])
        source_addresses      = optional(list(string), [])
        source_ip_groups      = optional(list(string), [])
      })), {})
      signature_overrides = optional(map(object({
        id    = optional(string)
        state = optional(string)
      })), {})
    }))
    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))
    tls_certificate = optional(object({
      key_vault_secret_id = string
      name                = string
    }))
    explicit_proxy = optional(object({
      enabled         = optional(bool)
      http_port       = optional(number)
      https_port      = optional(number)
      enable_pac_file = optional(bool)
      pac_file        = optional(string)
      pac_file_port   = optional(number)
    }))
    threat_intelligence_allowlist = optional(object({
      fqdns        = optional(list(string))
      ip_addresses = optional(list(string))
    }))
    insights = optional(object({
      enabled                            = bool
      default_log_analytics_workspace_id = string
      retention_in_days                  = optional(number)
      log_analytics_workspace = optional(map(object({
        id                = string
        firewall_location = string
      })), {})
    }))
  })

  validation {
    condition     = var.config.location != null || var.location != null
    error_message = "location must be provided either in the object or as a separate variable."
  }

  validation {
    condition     = var.config.resource_group_name != null || var.resource_group_name != null
    error_message = "resource group name must be provided either in the object or as a separate variable."
  }
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
