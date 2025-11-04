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

module "fw_policy" {
  source  = "cloudnationhq/fwp/azure"
  version = "~> 4.0"

  config = {
    name                = module.naming.firewall_policy.name
    resource_group_name = module.rg.groups.demo.name
    location            = module.rg.groups.demo.location
  }
}

module "collection_rule_groups" {
  source  = "cloudnationhq/fwp/azure//modules/collection-rule-groups"
  version = "~> 4.0"

  groups = local.collection_rule_groups
}
