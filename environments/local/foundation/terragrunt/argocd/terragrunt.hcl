include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${include.root.locals.env.locals.blueprints_repo}//foundation/argocd?ref=${include.root.locals.env.locals.blueprints_ref}"
}

dependencies {
  paths = ["../k3d"]
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
