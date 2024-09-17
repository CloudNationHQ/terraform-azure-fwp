# Complete

This example highlights the complete usage.

## Types

```hcl
config = object({
  name                              = string
  resource_group                    = string
  location                          = string
  sku                               = optional(string)
  threat_intelligence_mode          = optional(string)
  sql_redirect_allowed              = optional(bool)
  auto_learn_private_ranges_enabled = optional(bool)
  private_ip_ranges                 = optional(list(string))
  dns = optional(object({
    proxy_enabled = optional(bool)
    servers       = optional(list(string))
  }))
  intrusion_detection = optional(object({
    mode           = optional(string)
    private_ranges = optional(list(string))
    traffic_bypass = optional(map(object({
      name                  = string
      protocol              = string
      description           = optional(string)
      destination_ports     = optional(list(string))
      source_addresses      = optional(list(string))
      destination_addresses = optional(list(string))
    })))
    signature_overrides = optional(map(object({
      id    = string
      state = string
    })))
  }))
  explicit_proxy = optional(object({
    enabled    = optional(bool)
    http_port  = optional(number)
    https_port = optional(number)
  }))
  threat_intelligence_allowlist = optional(object({
    fqdns        = optional(list(string))
    ip_addresses = optional(list(string))
  }))
  insights = optional(object({
    enabled                            = optional(bool)
    default_log_analytics_workspace_id = optional(string)
    retention_in_days                  = optional(number)
  }))
})
```


## Notes

To enable tls inspection you need to have a certificate generated with the private key in a azure key vault.
