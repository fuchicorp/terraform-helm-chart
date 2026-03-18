# Changelog

All notable changes to this project will be documented in this file.

## [0.3.0](https://github.com/fuchicorp/terraform-helm-chart/compare/v0.2.1...v0.3.0) (2026-03-18)


### Features

* Implemented the issue and pull request AI labeler ([#43](https://github.com/fuchicorp/terraform-helm-chart/issues/43)) ([c975fcd](https://github.com/fuchicorp/terraform-helm-chart/commit/c975fcdad0fec081be4992055657970036d0f449))


### Bug Fixes

* add terraform installation step to pre-commit workflow ([5341f7f](https://github.com/fuchicorp/terraform-helm-chart/commit/5341f7fb34d7baccd24115fc464bb46446a4ccde))
* Fixed the pre commit syntax and added the lock file ([498a9b7](https://github.com/fuchicorp/terraform-helm-chart/commit/498a9b7c092dccd13b7765159124359e22ee9d69))
* run terraform init after installation in pre-commit workflow ([a34d713](https://github.com/fuchicorp/terraform-helm-chart/commit/a34d713188c72704ecfe3bced97581e2746ae934))
* update GitHub Actions versions to fix Node.js deprecation warning ([c71b858](https://github.com/fuchicorp/terraform-helm-chart/commit/c71b85843cc9e68f7c83a587c7e46f68427c32a9))

### [0.2.1](https://github.com/fuchicorp/terraform-helm-chart/compare/v0.2.0...v0.2.1) (2023-11-12)


### Bug Fixes

* .terraform.lock.hcl has to managed from the client side ([13af66d](https://github.com/fuchicorp/terraform-helm-chart/commit/13af66db2c1b1570a303b5d7f7869ee29523abb1))
* Removed the local and template after templatefile was implemented ([d181ad2](https://github.com/fuchicorp/terraform-helm-chart/commit/d181ad266fb5e9ea2dcb937e6af1510c75eaa2c0))

## [0.2.0](https://github.com/fuchicorp/terraform-helm-chart/compare/v0.1.1...v0.2.0) (2023-11-12)


### Features

* Added AI labeler and pre commit ([f08eaeb](https://github.com/fuchicorp/terraform-helm-chart/commit/f08eaebe4ff2ab056f251b32112e9650fa6c1bf4))


### Bug Fixes

* Any commit to any branch will be scanned ([5e33e48](https://github.com/fuchicorp/terraform-helm-chart/commit/5e33e48bc5cc7bfde1d28266c3028750cb562b5d))
* Centralize Semantic Release Versioning using Reusable GitHub Workflow ([#41](https://github.com/fuchicorp/terraform-helm-chart/issues/41)) ([5d2700c](https://github.com/fuchicorp/terraform-helm-chart/commit/5d2700cc556d13aef3a32531cb7d021cb734a402))
* Due to limitation from github github workflow should be stored in the public repo ([2241f91](https://github.com/fuchicorp/terraform-helm-chart/commit/2241f91b8a11a11edc4c1b056c1f90873e571be9))
* The pre commit workflow can be called manually ([d499129](https://github.com/fuchicorp/terraform-helm-chart/commit/d4991290982f7156c4cbdc3095f94b70c3ba94aa))
