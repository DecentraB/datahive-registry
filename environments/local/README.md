# Local Environment

Local is for developer bootstrap and fast validation.

Local Terragrunt infrastructure lives in `terragrunt`. Cluster units are under `terragrunt/clusters`, and services deployed onto the management cluster are under `terragrunt/management-cluster`. Tenant-owned product configuration stays under `domains/<domain>/products/<product>/envs/local`.
