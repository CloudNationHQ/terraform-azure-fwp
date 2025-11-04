# firewall policy
resource "azurerm_firewall_policy" "policy" {
  resource_group_name = coalesce(
    lookup(
      var.config, "resource_group_name", null
    ), var.resource_group_name
  )

  location = coalesce(
    lookup(var.config, "location", null
    ), var.location
  )

  name                              = var.config.name
  private_ip_ranges                 = var.config.private_ip_ranges
  sku                               = var.config.sku
  sql_redirect_allowed              = var.config.sql_redirect_allowed
  threat_intelligence_mode          = var.config.threat_intelligence_mode
  base_policy_id                    = var.config.base_policy_id
  auto_learn_private_ranges_enabled = var.config.auto_learn_private_ranges_enabled

  tags = coalesce(
    var.config.tags, var.tags
  )

  dynamic "dns" {
    for_each = lookup(var.config, "dns", null) != null ? [var.config.dns] : []

    content {
      proxy_enabled = dns.value.proxy_enabled
      servers       = dns.value.servers
    }
  }

  dynamic "intrusion_detection" {
    for_each = lookup(var.config, "intrusion_detection", null) != null ? [var.config.intrusion_detection] : []

    content {
      mode           = intrusion_detection.value.mode
      private_ranges = intrusion_detection.value.private_ranges

      dynamic "traffic_bypass" {
        for_each = lookup(
          intrusion_detection.value, "traffic_bypass", {}
        )

        content {
          name                  = traffic_bypass.key
          protocol              = traffic_bypass.value.protocol
          description           = traffic_bypass.value.description
          destination_addresses = traffic_bypass.value.destination_addresses
          destination_ip_groups = traffic_bypass.value.destination_ip_groups
          destination_ports     = traffic_bypass.value.destination_ports
          source_addresses      = traffic_bypass.value.source_addresses
          source_ip_groups      = traffic_bypass.value.source_ip_groups
        }
      }

      dynamic "signature_overrides" {
        for_each = lookup(
          intrusion_detection.value, "signature_overrides", {}
        )

        content {
          id    = signature_overrides.value.id
          state = signature_overrides.value.state
        }
      }
    }
  }

  dynamic "identity" {
    for_each = lookup(var.config, "identity", null) != null ? [var.config.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "tls_certificate" {
    for_each = lookup(var.config, "tls_certificate", null) != null ? [var.config.tls_certificate] : []

    content {
      key_vault_secret_id = tls_certificate.value.key_vault_secret_id
      name                = tls_certificate.value.name
    }
  }

  dynamic "explicit_proxy" {
    for_each = lookup(var.config, "explicit_proxy", null) != null ? [var.config.explicit_proxy] : []

    content {
      enabled         = explicit_proxy.value.enabled
      http_port       = explicit_proxy.value.http_port
      https_port      = explicit_proxy.value.https_port
      enable_pac_file = explicit_proxy.value.enable_pac_file
      pac_file        = explicit_proxy.value.pac_file
      pac_file_port   = explicit_proxy.value.pac_file_port
    }
  }

  dynamic "threat_intelligence_allowlist" {
    for_each = lookup(var.config, "threat_intelligence_allowlist", null) != null ? [var.config.threat_intelligence_allowlist] : []

    content {
      fqdns        = threat_intelligence_allowlist.value.fqdns
      ip_addresses = threat_intelligence_allowlist.value.ip_addresses
    }
  }

  dynamic "insights" {
    for_each = lookup(var.config, "insights", null) != null ? [var.config.insights] : []

    content {
      enabled                            = insights.value.enabled
      default_log_analytics_workspace_id = insights.value.default_log_analytics_workspace_id
      retention_in_days                  = insights.value.retention_in_days

      dynamic "log_analytics_workspace" {
        for_each = lookup(
          insights.value, "log_analytics_workspace", {}
        )

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

# role assignment
resource "azurerm_role_assignment" "role" {
  for_each = lookup(var.config, "tls_certificate", null) != null ? { "tls_cert" = var.config.tls_certificate } : {}

  scope                                  = each.value.key_vault_id
  name                                   = each.value.role_assignment_name
  role_definition_name                   = each.value.role_definition_name
  role_definition_id                     = each.value.role_definition_id
  principal_id                           = each.value.principal_id
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  description                            = each.value.description
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
  principal_type                         = each.value.principal_type
}
