# ip groups
resource "azurerm_ip_group" "ipgroup" {
  for_each = try(
    var.ip_groups, {}
  )

  name = coalesce(
    each.value.name, try(
      join("-", [var.naming.ip_group, each.key]), null
    ), each.key
  )

  resource_group_name = coalesce(
    lookup(
      each.value, "resource_group_name", null
    ), var.resource_group_name
  )

  location = coalesce(
    lookup(each.value, "location", null
    ), var.location
  )

  cidrs = can(
    tolist(each.value.cidr)
  ) ? tolist(each.value.cidr) : values(each.value.cidr)

  tags = coalesce(
    each.value.tags, var.tags
  )
}
