# DataHive Registry

The registry is the self-service entrypoint for DataHive tenants.

Platform-owned foundation configuration lives under `environments/` because infrastructure differs by deployment environment. Tenant-owned data product configuration lives under `domains/` because product teams should manage one product in one place, with all environment overlays kept together.

## Layout

```text
environments/<env>/foundation/terragrunt/
domains/<domain>/products/<product>/
```

Use `domains/_template/products/_template` when onboarding a new data product.

## User Guide

Initial temporary command:

```bash
terragrunt run-all apply --working-dir datahive-registry/environments/local/foundation/terragrunt --source-update --source-map "git::ssh://git@github.com/DecentraB/datahive-blueprints.git=${PWD}/datahive-blueprints"
```