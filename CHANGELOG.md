# Changelog

## [2.3.0](https://github.com/CloudNationHQ/terraform-azure-fwp/compare/v2.2.0...v2.3.0) (2025-01-20)


### Features

* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#12](https://github.com/CloudNationHQ/terraform-azure-fwp/issues/12)) ([424ff6b](https://github.com/CloudNationHQ/terraform-azure-fwp/commit/424ff6bb6c2d6e250967789b7502760d1b5bb9ba))
* **deps:** bump golang.org/x/crypto from 0.29.0 to 0.31.0 in /tests ([#15](https://github.com/CloudNationHQ/terraform-azure-fwp/issues/15)) ([5fe10cc](https://github.com/CloudNationHQ/terraform-azure-fwp/commit/5fe10cc928ad6e225456884fe400d6df68529d26))
* **deps:** bump golang.org/x/net from 0.31.0 to 0.33.0 in /tests ([#16](https://github.com/CloudNationHQ/terraform-azure-fwp/issues/16)) ([e4ef9bc](https://github.com/CloudNationHQ/terraform-azure-fwp/commit/e4ef9bce7c550a3f2709ac4959a619c7c7b4bc64))
* remove temporary files when deployment tests fails ([#13](https://github.com/CloudNationHQ/terraform-azure-fwp/issues/13)) ([8b553c3](https://github.com/CloudNationHQ/terraform-azure-fwp/commit/8b553c3bf456c30a805dc125ff7b4e2704a8d8b0))

## [2.2.0](https://github.com/CloudNationHQ/terraform-azure-fwp/compare/v2.1.0...v2.2.0) (2024-11-11)


### Features

* enhance testing with sequential, parallel modes and flags for exceptions and skip-destroy ([#9](https://github.com/CloudNationHQ/terraform-azure-fwp/issues/9)) ([19142dc](https://github.com/CloudNationHQ/terraform-azure-fwp/commit/19142dc05bec0f0bcf2b50c2493896be7dce7110))

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
