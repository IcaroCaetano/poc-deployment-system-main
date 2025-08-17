#############################################################
# Terraform Configuration
# 
# Este bloco define:
# - A versão mínima do Terraform que deve ser usada.
# - Os provedores necessários para este projeto, incluindo suas fontes
#   e versões.
#
# Providers utilizados:
# - kind: Permite criar e gerenciar clusters locais do Kubernetes usando Kind.
# - kubernetes: Permite gerenciar recursos dentro de clusters Kubernetes.
# - helm: Permite gerenciar pacotes Helm charts em clusters Kubernetes.
#############################################################

#######################################################################
# Terraform Configuration
#
# This block defines:
# - The minimum Terraform version that should be used.
# - The providers required for this project, including their sources
# and versions.
#
# Providers used:
# - kind: Allows you to create and manage local Kubernetes clusters using Kind.
# - kubernetes: Allows you to manage resources within Kubernetes clusters.
# - helm: Allows you to manage Helm chart packages in Kubernetes clusters. #############################################################
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    # Provedor Kind
    # Usado para criar e gerenciar clusters Kubernetes locais com Kind (Kubernetes in Docker).

    # Kind Provider
    # Used to create and manage local Kubernetes clusters with Kind (Kubernetes in Docker).
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.2.1"
    }

    # Provedor Kubernetes
    # Usado para gerenciar objetos dentro de clusters Kubernetes,
    # como Secrets, ConfigMaps, Deployments, Services, etc.

    # Kubernetes Provider
    # Used to manage objects within Kubernetes clusters,
    # such as Secrets, ConfigMaps, Deployments, Services, etc.
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }

   # Provedor Helm
   # Usado para instalar e gerenciar pacotes Helm em um cluster Kubernetes.

    # Helm Provider
    # Used to install and manage Helm packages in a Kubernetes cluster.
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17.0"
    }
  }
}
