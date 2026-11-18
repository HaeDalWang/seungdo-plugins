#!/usr/bin/env bash
# 클러스터 버전과 애드온 버전이 파일에 적힌 작업 폴더를 만든다.
set -eu
mkdir -p terraform
cat > terraform/eks.tf <<'DOC'
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "acme-prod"
  cluster_version = "1.29"

  cluster_addons = {
    coredns    = { addon_version = "v1.11.1-eksbuild.4" }
    kube-proxy = { addon_version = "v1.29.0-eksbuild.1" }
    vpc-cni    = { addon_version = "v1.16.0-eksbuild.1" }
  }

  eks_managed_node_groups = {
    default = { instance_types = ["m6i.large"], min_size = 3, max_size = 6 }
  }
}
DOC
