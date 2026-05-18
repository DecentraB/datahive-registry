include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "providers" {
  path = find_in_parent_folders("providers.hcl")
}

terraform {
  source = "${include.root.locals.env.locals.blueprints_repo}//terraform-modules/argocd?ref=${include.root.locals.env.locals.blueprints_ref}"
}

dependencies {
  paths = ["../../cluster"]
}

inputs = {
  namespace     = "argocd"
  release_name  = "argocd"
  chart_version = "9.5.13"
  timeout       = 1800
  extra_values = {
    server = {
      extraArgs = [
        "--insecure"
      ]
    }
  }
}
