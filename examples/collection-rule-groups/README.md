# Collection Rule Groups

This deploys collection rule groups, collections and rules.

## Types

```hcl
collection_rule_groups = map(object({
  priority           = optional(number)
  firewall_policy_id = optional(string)
  network_rule_collections = optional(map(object({
    name     = string
    priority = number
    action   = string
    rules = map(object({
      name                  = string
      description           = optional(string)
      protocols             = list(string)
      destination_ports     = list(string)
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_addresses = optional(list(string))
      destination_ip_groups = optional(list(string))
      destination_fqdns     = optional(list(string))
    }))
  })))
  application_rule_collections = optional(map(object({
    name     = string
    priority = number
    action   = string
    rules = map(object({
      name              = string
      description       = optional(string)
      source_addresses  = optional(list(string))
      source_ip_groups  = optional(list(string))
      destination_fqdns = optional(list(string))
      protocols = list(object({
        type = string
        port = number
      }))
    }))
  })))
  nat_rule_collections = optional(map(object({
    name     = string
    priority = number
    action   = string
    rules = map(object({
      name                = string
      description         = optional(string)
      protocols           = list(string)
      source_addresses    = optional(list(string))
      source_ip_groups    = optional(list(string))
      destination_address = optional(string)
      destination_ports   = optional(list(string))
      translated_address  = optional(string)
      translated_fqdn     = optional(string)
    }))
  })))
}))
```

## Notes

The azure api for collections and rules is unordered, causing rule indexes to shift unexpectedly, even when using maps.
