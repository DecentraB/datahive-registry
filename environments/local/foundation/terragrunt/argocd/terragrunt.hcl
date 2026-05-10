include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "${local.env.locals.blueprints_repo}//foundation/argocd?ref=${local.env.locals.blueprints_ref}"
}

dependency "k3d" {
  config_path = "../k3d"
}

inputs = {
  cluster_name  = try(dependency.k3d.outputs.cluster_name, local.env.locals.cluster_name)
  namespace     = "argocd"
  release_name  = "argocd"
  chart_version = "9.5.13"
  timeout       = 1800
  extra_values  = {}
}
