variable "groups" {
  description = "Contains all firewall policy rule collection groups config"
  type = map(object({
    name               = optional(string)
    firewall_policy_id = optional(string, null)
    priority           = number
    network_rule_collections = optional(map(object({
      name     = optional(string)
      priority = number
      action   = string
      rules = map(object({
        name                  = optional(string)
        description           = optional(string, null)
        protocols             = list(string)
        destination_ports     = list(string)
        destination_addresses = optional(list(string), [])
        destination_fqdns     = optional(list(string), [])
        source_addresses      = optional(list(string), [])
        source_ip_groups      = optional(list(string), [])
        destination_ip_groups = optional(list(string), [])
      }))
    })), {})
    application_rule_collections = optional(map(object({
      name     = optional(string)
      priority = number
      action   = string
      rules = map(object({
        name                  = optional(string)
        description           = optional(string, null)
        source_addresses      = optional(list(string), null)
        source_ip_groups      = optional(list(string), null)
        destination_addresses = optional(list(string), null)
        destination_urls      = optional(list(string), null)
        destination_fqdns     = optional(list(string), null)
        destination_fqdn_tags = optional(list(string), null)
        terminate_tls         = optional(bool, null)
        web_categories        = optional(list(string), null)
        protocols = optional(list(object({
          type = string
          port = number
        })), [])
        http_headers = optional(list(object({
          type = string
          port = number
        })), [])
      }))
    })), {})
    nat_rule_collections = optional(map(object({
      name     = optional(string)
      priority = number
      action   = string
      rules = map(object({
        name                = optional(string)
        description         = optional(string, null)
        protocols           = list(string)
        source_addresses    = optional(list(string), null)
        source_ip_groups    = optional(list(string), null)
        destination_address = optional(string, null)
        destination_ports   = optional(list(string), null)
        translated_address  = optional(string, null)
        translated_fqdn     = optional(string, null)
        translated_port     = optional(string, null)
      }))
    })), {})
  }))
}
