variable "config" {
  description = "Contains all firewall policy configuration"
  type = object({
    name                              = string
    resource_group_name               = optional(string, null)
    location                          = optional(string, null)
    private_ip_ranges                 = optional(list(string), null)
    sku                               = optional(string, "Standard")
    sql_redirect_allowed              = optional(bool, null)
    threat_intelligence_mode          = optional(string, "Alert")
    base_policy_id                    = optional(string, null)
    auto_learn_private_ranges_enabled = optional(bool, null)
    tags                              = optional(map(string))
    key_vault_id                      = optional(string, null)
    principal_id                      = optional(string, null)
    dns = optional(object({
      proxy_enabled = optional(bool, false)
      servers       = optional(list(string), [])
    }), null)
    intrusion_detection = optional(object({
      mode           = optional(string, null)
      private_ranges = optional(list(string), null)
      traffic_bypass = optional(map(object({
        protocol              = string
        description           = optional(string, null)
        destination_addresses = optional(list(string), [])
        destination_ip_groups = optional(list(string), [])
        destination_ports     = optional(list(string), [])
        source_addresses      = optional(list(string), [])
        source_ip_groups      = optional(list(string), [])
      })), {})
      signature_overrides = optional(map(object({
        id    = optional(string, null)
        state = optional(string, null)
      })), {})
    }), null)
    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }), null)
    tls_certificate = optional(object({
      key_vault_secret_id = string
      name                = string
    }), null)
    explicit_proxy = optional(object({
      enabled         = optional(bool, null)
      http_port       = optional(number, null)
      https_port      = optional(number, null)
      enable_pac_file = optional(bool, null)
      pac_file        = optional(string, null)
      pac_file_port   = optional(number, null)
    }), null)
    threat_intelligence_allowlist = optional(object({
      fqdns        = optional(list(string), null)
      ip_addresses = optional(list(string), null)
    }), null)
    insights = optional(object({
      enabled                            = bool
      default_log_analytics_workspace_id = string
      retention_in_days                  = optional(number, null)
      log_analytics_workspace = optional(map(object({
        id                = string
        firewall_location = string
      })), {})
    }), null)
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
