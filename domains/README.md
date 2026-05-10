# Domains

Each domain owns its products below:

```text
domains/<domain>/products/<product>/
```

Each product keeps metadata, contracts, runtime config, and all environment overlays together. Do not organize tenant product submissions as `environments/<env>/<product>`; that splits one product across unrelated folders and makes self-service ownership harder.

