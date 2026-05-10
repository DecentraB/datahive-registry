include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "${local.env.locals.blueprints_repo}//foundation/cluster/k3d?ref=${local.env.locals.blueprints_ref}"
}

inputs = {
  cluster_name = local.env.locals.cluster_name
  server_count = 1
  agent_count  = 2
  k3s_version  = "v1.31.5-k3s1"
  api_port     = 6443
}
