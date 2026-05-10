locals {
  env_name                = "local"
  management_cluster_name = "datahive-management"
  substrate_cluster_name  = "datahive-substrate"
  domain_cluster_name     = "datahive-domain"
  blueprints_repo         = "git::ssh://git@github.com/DecentraB/datahive-blueprints.git"
  blueprints_ref          = "main"
}
