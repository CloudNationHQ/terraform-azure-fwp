# Ip Groups

This submodule focuses on the effective management of ip groups.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_ip_group.ipgroup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ip_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ip_groups"></a> [ip\_groups](#input\_ip\_groups) | describes all ip groups | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | contains the region | `string` | `null` | no |
| <a name="input_naming"></a> [naming](#input\_naming) | contains naming convention | `map(string)` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | contains the resource group name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_groups"></a> [ip\_groups](#output\_ip\_groups) | Contains all ip groups configuration |
<!-- END_TF_DOCS -->
