locals {
  env          = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  cluster_name = join("-", [local.env.locals.platform_name, "data"])
}
