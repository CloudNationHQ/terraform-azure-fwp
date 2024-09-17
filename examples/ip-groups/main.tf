module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 1.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name
      location = "westeurope"
    }
  }
}

module "fw_policy" {
  source  = "cloudnationhq/fwp/azure"
  version = "~> 1.0"

  config = {
    name           = module.naming.firewall_policy.name
    resource_group = module.rg.groups.demo.name
    location       = module.rg.groups.demo.location
  }
}

module "collection_rule_groups" {
  source  = "cloudnationhq/fwp/azure//modules/collection-rule-groups"
  version = "~> 1.0"

  resource_group = module.rg.groups.demo.name
  location       = module.rg.groups.demo.location
  groups         = local.collection_rule_groups
}

module "ip_groups" {
  source  = "cloudnationhq/fwp/azure//modules/ip-groups"
  version = "~> 1.0"

  resourcegroup = module.rg.groups.demo.name
  location      = module.rg.groups.demo.location
  ip_groups     = local.ip_groups
}
