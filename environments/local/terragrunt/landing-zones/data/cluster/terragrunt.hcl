include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  zone = read_terragrunt_config(find_in_parent_folders("zone.hcl"))
}

terraform {
  source = "${include.root.locals.env.locals.platform_repo}//blueprints/terraform-modules/cluster/k3d?ref=${include.root.locals.env.locals.blueprints_ref}"
}

inputs = {
  cluster_name = local.zone.locals.cluster_name
  server_count = 1
  agent_count  = 0
  k3s_version  = "v1.31.5-k3s1"
}
