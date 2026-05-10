locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  provider_unit_paths = [
    "argocd",
    "vault",
  ]

  providers_tf = <<EOF
data "external" "k3d_cluster_info" {
  program = ["sh", "-c", <<EOT
k3d kubeconfig get ${local.env.locals.cluster_name} | yq -o json . | jq -r '.clusters[0].cluster | {server: .server, certificate_authority_data: ."certificate-authority-data"}'
EOT
  ]
}

data "external" "k3d_cluster_auth" {
  program = ["sh", "-c", <<EOT
k3d kubeconfig get ${local.env.locals.cluster_name} | yq -o json . | jq -r '.users[] | select(.name == "admin@k3d-${local.env.locals.cluster_name}") | .user | {client_certificate_data: ."client-certificate-data", client_key_data: ."client-key-data"}'
EOT
  ]
}

provider "kubernetes" {
  host                   = data.external.k3d_cluster_info.result.server
  cluster_ca_certificate = base64decode(data.external.k3d_cluster_info.result.certificate_authority_data)
  client_certificate     = base64decode(data.external.k3d_cluster_auth.result.client_certificate_data)
  client_key             = base64decode(data.external.k3d_cluster_auth.result.client_key_data)
}

provider "helm" {
  kubernetes = {
    host                   = data.external.k3d_cluster_info.result.server
    cluster_ca_certificate = base64decode(data.external.k3d_cluster_info.result.certificate_authority_data)
    client_certificate     = base64decode(data.external.k3d_cluster_auth.result.client_certificate_data)
    client_key             = base64decode(data.external.k3d_cluster_auth.result.client_key_data)
  }
}
EOF
}

remote_state {
  backend = "local"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    path = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/terraform.tfstate"
  }
}

generate "providers" {
  path      = "providers.generated.tf"
  if_exists = "overwrite_terragrunt"
  contents  = contains(local.provider_unit_paths, path_relative_to_include()) ? local.providers_tf : ""
}
