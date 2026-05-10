# DataHive Registry

The registry is the self-service entrypoint for DataHive tenants.

Environment-specific platform configuration lives under `environments/`. Tenant-owned data product configuration lives under `domains/` because product teams should manage one product in one place, with all environment overlays kept together.

## Layout

```text
environments/<env>/terragrunt/
domains/<domain>/products/<product>/
```

For local development, the Terragrunt root is `environments/local/terragrunt`:

```text
environments/local/terragrunt/
  env.hcl
  root.hcl
  clusters/
    management/
    substrate/
    domain/
  management-cluster/
    providers.hcl
    argocd/
    vault/
```

The `clusters/*` units create the local k3d clusters. Units under `management-cluster/*` deploy services onto the management cluster and depend on `clusters/management`.

Use `domains/_template/products/_template` when onboarding a new data product.

## User Guide

Apply the full local stack:

```bash
terragrunt run-all apply --working-dir datahive-registry/environments/local/terragrunt --source-update --source-map "git::ssh://git@github.com/DecentraB/datahive-blueprints.git=${PWD}/datahive-blueprints"
```

Apply only the local clusters:

```bash
terragrunt run-all apply --working-dir datahive-registry/environments/local/terragrunt/clusters --source-update --source-map "git::ssh://git@github.com/DecentraB/datahive-blueprints.git=${PWD}/datahive-blueprints"
```
