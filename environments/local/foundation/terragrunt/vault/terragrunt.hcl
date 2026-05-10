include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.env.locals.blueprints_repo}//foundation/vault?ref=${include.root.locals.env.locals.blueprints_ref}"
}

dependencies {
  paths = ["../k3d"]
}

inputs = {
  namespace     = "vault"
  release_name  = "vault"
  chart_version = "0.32.0"
  timeout       = 1800
  extra_values = {
    server = {
      dev = {
        enabled = true
      }
    }
  }
}
