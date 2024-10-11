# Changelog

## [2.1.0](https://github.com/CloudNationHQ/terraform-azure-fwp/compare/v2.0.0...v2.1.0) (2024-10-11)


### Features

* auto generated docs and refine makefile ([#7](https://github.com/CloudNationHQ/terraform-azure-fwp/issues/7)) ([75ba327](https://github.com/CloudNationHQ/terraform-azure-fwp/commit/75ba327a3fa5dcc7f1d2b4af61aa5e1a1b77013d))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#6](https://github.com/CloudNationHQ/terraform-azure-fwp/issues/6)) ([eaa683d](https://github.com/CloudNationHQ/terraform-azure-fwp/commit/eaa683d08b8526b5f5386cd16b72f42d4d54fc28))

## [2.0.0](https://github.com/CloudNationHQ/terraform-azure-fwp/compare/v1.0.0...v2.0.0) (2024-09-25)


### ⚠ BREAKING CHANGES

* Version 4 of the azurerm provider includes breaking changes.

### Features

* upgrade azurerm provider to v4 ([#4](https://github.com/CloudNationHQ/terraform-azure-fwp/issues/4)) ([18ec3fc](https://github.com/CloudNationHQ/terraform-azure-fwp/commit/18ec3fcc38e5dee9b0870f26d4a78e734582577d))

### Upgrade from v1.0.0 to v2.0.0:

- Update module reference to: `version = "~> 2.0"`
- Rename variable in submodule ip-groups:
  - resourcegroup -> resource_group

## 1.0.0 (2024-09-17)


### Features

* add initial resources ([#2](https://github.com/CloudNationHQ/terraform-azure-fwp/issues/2)) ([1461e10](https://github.com/CloudNationHQ/terraform-azure-fwp/commit/1461e1018c92d3d35688e1457f9ba5c11e7a8829))
