# Firewall Policy

This Terraform module streamlines azure firewall policy management with customizable rule groups, collections, rules, and ip groups for scalable, secure network policies

## Goals

The main objective is to create a more logic data structure, achieved by combining and grouping related resources together in a complex object.

The structure of the module promotes reusability. It's intended to be a repeatable component, simplifying the process of building diverse workloads and platform accelerators consistently.

A primary goal is to utilize keys and values in the object that correspond to the REST API's structure. This enables us to carry out iterations, increasing its practical value as time goes on.

A last key goal is to separate logic from configuration in the module, thereby enhancing its scalability, ease of customization, and manageability.

## Non-Goals

These modules are not intended to be complete, ready-to-use solutions; they are designed as components for creating your own patterns.

They are not tailored for a single use case but are meant to be versatile and applicable to a range of scenarios.

Security standardization is applied at the pattern level, while the modules include default values based on best practices but do not enforce specific security standards.

End-to-end testing is not conducted on these modules, as they are individual components and do not undergo the extensive testing reserved for complete patterns or solutions.

## Features

- streamlined support for creating and managing firewall policies
- multiple collection groups, collections and rules support
- optional ip group integration in collection rule groups
- utilization of terratest for robust validation.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.61 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.61 |

## Modules

| Name | Source |
|------|--------|
| [collection-rule-groups](./modules/collection-rule-groups) | resource |
| [ip-groups](./modules/ip-groups) | resource |

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy) | resource |
| [azurerm_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Required |
| :-- | :-- | :-- | :-- |
| `config` | contains all firewall policy configuration | object | yes |
| `naming` | contains naming convention | string | yes |
| `location` | default azure region to be used | string | no |
| `resource_group` | default resource group to be used | string | no |
| `tags` | tags to be added to the resources | map(string) | no |

## Outputs

| Name | Description |
| :-- | :-- |
| `config` | contains all firewall policy configuration |

## Testing

As a prerequirement, please ensure that both go and terraform are properly installed on your system.

The [Makefile](Makefile) includes two distinct variations of tests. The first one is designed to deploy different usage scenarios of the module. These tests are executed by specifying the TF_PATH environment variable, which determines the different usages located in the example directory.

To execute this test, input the command ```make test TF_PATH=default```, substituting default with the specific usage you wish to test.

The second variation is known as a extended test. This one performs additional checks and can be executed without specifying any parameters, using the command ```make test_extended```.

Both are designed to be executed locally and are also integrated into the github workflow.

Each of these tests contributes to the robustness and resilience of the module. They ensure the module performs consistently and accurately under different scenarios and configurations.

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

## Authors

Module is maintained by [these awesome contributors](https://github.com/cloudnationhq/terraform-azure-fwp/graphs/contributors).

## Contributing

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md).

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/firewall/policy-rule-sets)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/virtualnetwork/firewall-policies)