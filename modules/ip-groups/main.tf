# ip groups
resource "azurerm_ip_group" "ipgroup" {
  for_each = try(
    var.ip_groups, {}
  )

  name                = try(each.value.name, join("-", [var.naming.ip_group, each.key]))
  location            = var.location
  resource_group_name = var.resourcegroup
  cidrs               = can(tolist(each.value.cidr)) ? tolist(each.value.cidr) : values(each.value.cidr)
  tags                = try(each.value.tags, {})
}
