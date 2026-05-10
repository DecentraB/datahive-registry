include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.env.locals.blueprints_repo}//terraform-modules/cluster/k3d?ref=${include.root.locals.env.locals.blueprints_ref}"
}

inputs = {
  cluster_name = include.root.locals.env.locals.substrate_cluster_name
  server_count = 1
  agent_count  = 0
  k3s_version  = "v1.31.5-k3s1"
}
