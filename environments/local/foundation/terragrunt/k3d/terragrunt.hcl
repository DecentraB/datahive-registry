include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.env.locals.blueprints_repo}//foundation/cluster/k3d?ref=${include.root.locals.env.locals.blueprints_ref}"
}

inputs = {
  cluster_name = include.root.locals.env.locals.cluster_name
  server_count = 1
  agent_count  = 2
  k3s_version  = "v1.31.5-k3s1"
  api_port     = 6443
}
