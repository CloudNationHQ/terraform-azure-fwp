# firewall policy
resource "azurerm_firewall_policy" "policy" {

  name                              = try(var.config.name, var.naming.firewall_policy)
  resource_group_name               = coalesce(lookup(var.config, "resource_group", null), var.resource_group)
  location                          = coalesce(lookup(var.config, "location", null), var.location)
  private_ip_ranges                 = try(var.config.private_ip_ranges, null)
  sku                               = try(var.config.sku, "Standard")
  sql_redirect_allowed              = try(var.config.sql_redirect_allowed, null)
  threat_intelligence_mode          = try(var.config.threat_intelligence_mode, "Alert")
  base_policy_id                    = try(var.config.base_policy_id, null)
  auto_learn_private_ranges_enabled = try(var.config.auto_learn_private_ranges_enabled, null)
  tags                              = try(var.config.tags, var.tags, {})

  dynamic "dns" {
    for_each = lookup(var.config, "dns", null) != null ? { "default" = var.config.dns } : {}

    content {
      proxy_enabled = try(dns.value.proxy_enabled, false)
      servers       = try(dns.value.servers, [])
    }
  }

  dynamic "intrusion_detection" {
    for_each = lookup(var.config, "intrusion_detection", null) != null ? { "default" = var.config.intrusion_detection } : {}

    content {
      mode           = try(intrusion_detection.value.mode, null)
      private_ranges = try(intrusion_detection.value.private_ranges, null)

      dynamic "traffic_bypass" {
        for_each = lookup(intrusion_detection.value, "traffic_bypass", {})

        content {
          name                  = traffic_bypass.key
          protocol              = traffic_bypass.value.protocol
          description           = lookup(traffic_bypass.value, "description", null)
          destination_addresses = lookup(traffic_bypass.value, "destination_addresses", [])
          destination_ip_groups = lookup(traffic_bypass.value, "destination_ip_groups", [])
          destination_ports     = lookup(traffic_bypass.value, "destination_ports", [])
          source_addresses      = lookup(traffic_bypass.value, "source_addresses", [])
          source_ip_groups      = lookup(traffic_bypass.value, "source_ip_groups", [])
        }
      }

      dynamic "signature_overrides" {
        for_each = lookup(intrusion_detection.value, "signature_overrides", {})

        content {
          id    = try(signature_overrides.value.id, null)
          state = try(signature_overrides.value.state, null)
        }
      }
    }
  }

  dynamic "identity" {
    for_each = (lookup(var.config, "identity", null) != null || lookup(var.config, "tls_certificate", null) != null) ? [1] : []

    content {
      type = "UserAssigned"

      identity_ids = concat(
        lookup(var.config, "tls_certificate", null) != null ? [azurerm_user_assigned_identity.fw_policy_identity["tls_cert"].id] : [],
        lookup(var.config, "identity", null) != null ? var.config.identity.identity_ids : []
      )
    }
  }

  dynamic "tls_certificate" {
    for_each = lookup(var.config, "tls_certificate", null) != null ? { "default" = var.config.tls_certificate } : {}

    content {
      key_vault_secret_id = tls_certificate.value.key_vault_secret_id
      name                = tls_certificate.value.name
    }
  }

  dynamic "explicit_proxy" {
    for_each = lookup(var.config, "explicit_proxy", null) != null ? { "default" = var.config.explicit_proxy } : {}

    content {
      enabled         = try(explicit_proxy.value.enabled, null)
      http_port       = try(explicit_proxy.value.http_port, null)
      https_port      = try(explicit_proxy.value.https_port, null)
      enable_pac_file = try(explicit_proxy.value.enable_pac_file, null)
      pac_file        = try(explicit_proxy.value.pac_file, null)
      pac_file_port   = try(explicit_proxy.value.pac_file_port, null)
    }
  }

  dynamic "threat_intelligence_allowlist" {
    for_each = lookup(var.config, "threat_intelligence_allowlist", null) != null ? { "default" = var.config.threat_intelligence_allowlist } : {}

    content {
      fqdns        = try(threat_intelligence_allowlist.value.fqdns, null)
      ip_addresses = try(threat_intelligence_allowlist.value.ip_addresses, null)
    }
  }

  dynamic "insights" {
    for_each = lookup(var.config, "insights", null) != null ? { "default" = var.config.insights } : {}

    content {
      enabled                            = insights.value.enabled
      default_log_analytics_workspace_id = insights.value.default_log_analytics_workspace_id
      retention_in_days                  = try(insights.value.retention_in_days, null)

      dynamic "log_analytics_workspace" {
        for_each = lookup(insights.value, "log_analytics_workspace", {})

        content {
          id                = log_analytics_workspace.value.id
          firewall_location = log_analytics_workspace.value.firewall_location
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [azurerm_role_assignment.role]
}

# user assigned identity
resource "azurerm_user_assigned_identity" "uai" {
  for_each = lookup(var.config, "tls_certificate", null) != null ? { "tls_cert" = var.config.tls_certificate } : {}

  name                = "id-fwpolicy-${var.config.name}"
  resource_group_name = coalesce(lookup(var.config, "resource_group", null), var.resource_group)
  location            = coalesce(lookup(var.config, "location", null), var.location)

  tags = try(var.config.tags, var.tags, {})
}

# role assignment
resource "azurerm_role_assignment" "role" {
  for_each = lookup(var.config, "tls_certificate", null) != null ? { "tls_cert" = var.config.tls_certificate } : {}

  scope                                  = var.config.key_vault_id
  role_definition_name                   = "Key Vault Secrets User"
  principal_id                           = azurerm_user_assigned_identity.uai[each.key].principal_id
  description                            = "Role Based Access Control for Firewall Policy to access Key Vault"
  condition                              = try(var.config.condition, null)
  condition_version                      = try(var.config.condition_version, null)
  delegated_managed_identity_resource_id = try(var.config.delegated_managed_identity_resource_id, null)
}
