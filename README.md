# DataHive Registry

The registry is the self-service entrypoint for DataHive tenants.

Environment-specific platform configuration lives under `environments/`. Tenant-owned data product configuration lives under `domains/` because product teams should manage one product in one place, with all environment overlays kept together.

## Layout

```text
environments/<env>/terragrunt/
domains/<domain>/products/<product>/
```

For local development and production-topology simulation, the Terragrunt root is `environments/local/terragrunt`:

```text
environments/local/terragrunt/
  env.hcl
  root.hcl
  landing-zones/
    management/
      zone.hcl
      providers.hcl
      cluster/
      addons/
        argocd/
        vault/
    data/
      zone.hcl
      providers.hcl
      cluster/
      addons/
        vault-client/
      layers/
        substrate/
        domains/
```

Each `landing-zones/<zone>/cluster` unit creates one local k3d cluster for that landing zone. Add-ons live under the same zone folder and include that zone's `providers.hcl`, so they target the kubeconfig for the cluster they belong to.

The local environment intentionally models a future multi-zone production topology. Management is the control-plane landing zone. Argo CD and Vault are installed there first. Data is the local data landing zone: it owns one workload cluster and contains one shared substrate layer plus multiple domain-owned areas.

Shared data substrate resources such as object storage, Polaris, StarRocks, OpenMetadata, policy, observability, and secrets integration belong under `landing-zones/data/layers/substrate/`. Domain-owned runtime resources such as product namespaces, Kafka and Kafka Connect, dbt, Dagster, Ray, contracts, and quality checks belong under `landing-zones/data/layers/domains/`. Vault remains centralized per platform security boundary; workload clusters should integrate with it through landing-zone-specific auth mounts and client-side secret delivery rather than running separate Vault servers by default.

Future businesses, regions, acquisitions, or major business capabilities should add a landing zone named for that business boundary. Each such landing zone should contain exactly one shared substrate layer and one or more domain-owned areas; substrate is a platform layer, not a landing zone or ownership boundary. Environment-global resources should live outside `landing-zones`.

Use `domains/_template/products/_template` when onboarding a new data product.

## User Guide

Apply the full local stack:

```bash
terragrunt run-all apply --working-dir datahive-registry/environments/local/terragrunt --queue-include-external --source-update --source-map "git::ssh://git@github.com/DecentraB/datahive-blueprints.git=${PWD}/datahive-blueprints"
```

Apply only the local Kubernetes clusters:

```bash
terragrunt run-all apply --working-dir datahive-registry/environments/local/terragrunt --queue-include-dir "landing-zones/*/cluster" --queue-strict-include --queue-include-external --source-update --source-map "git::ssh://git@github.com/DecentraB/datahive-blueprints.git=${PWD}/datahive-blueprints"
```
