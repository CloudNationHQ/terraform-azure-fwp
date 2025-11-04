module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.24"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "analytics" {
  source  = "cloudnationhq/law/azure"
  version = "~> 3.0"

  workspace = {
    name                = module.naming.log_analytics_workspace.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
  }
}

module "fw_policy" {
  source  = "cloudnationhq/fwp/azure"
  version = "~> 4.0"

  config = {
    name                              = module.naming.firewall_policy.name
    resource_group_name               = module.rg.groups.demo.name
    location                          = module.rg.groups.demo.location
    sku                               = "Premium"
    threat_intelligence_mode          = "Deny"
    sql_redirect_allowed              = true
    auto_learn_private_ranges_enabled = true

    private_ip_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]

    dns = {
      proxy_enabled = true
      servers       = ["10.0.0.4", "10.0.0.5"]
    }

    intrusion_detection = {
      mode           = "Alert"
      private_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
      traffic_bypass = {
        azure_load_balancer_probes = {
          protocol              = "TCP"
          description           = "Bypass intrusion detection for Azure Load Balancer health probes"
          destination_ports     = ["80", "443", "8080"]
          source_addresses      = ["168.63.129.16"]
          destination_addresses = ["10.1.0.0/24"]
          destination_ip_groups = []
          source_ip_groups      = []
        }
      }
      signature_overrides = {
        ms_ise_rule = {
          id    = "2024897"
          state = "Off"
        }
      }
    }

    explicit_proxy = {
      enabled    = true
      http_port  = 8080
      https_port = 8443
    }

    threat_intelligence_allowlist = {
      fqdns        = ["*.microsoft.com", "*.windowsupdate.com"]
      ip_addresses = ["40.126.1.100", "40.126.1.101"]
    }

    insights = {
      enabled                            = true
      default_log_analytics_workspace_id = module.analytics.workspace.id
      retention_in_days                  = 30
    }
  }
}
