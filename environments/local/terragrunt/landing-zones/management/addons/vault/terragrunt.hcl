include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "providers" {
  path = find_in_parent_folders("providers.hcl")
}

terraform {
  source = "${include.root.locals.env.locals.platform_repo}//blueprints/terraform-modules/vault?ref=${include.root.locals.env.locals.blueprints_ref}"
}

dependencies {
  paths = ["../../cluster"]
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
