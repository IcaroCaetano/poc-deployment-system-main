# Este arquivo define Secrets no Kubernetes usando opentofu, que armazenam informações sensíveis, como credenciais, de forma segura.
# Secret que armazena credenciais para acessar o GitHub Container Registry (GHCR) a partir do Jenkins

# This file defines Secrets in Kubernetes using opentofu, which store sensitive information, such as credentials, securely.
# Secret that stores credentials to access GitHub Container Registry (GHCR) from Jenkins
resource "kubernetes_secret" "ghcr" {
  metadata {
    # Nome do Secret no Kubernetes: jenkins-ghcr-secret
    # Secret name in Kubernetes: jenkins-ghcr-secret
    name      = "jenkins-ghcr-secret"
    # Namespace onde o Secret será criado, usando o namespace infra definido anteriormente.
    # Namespace where the Secret will be created, using the previously defined infra namespace.
    namespace = kubernetes_namespace.infra.metadata[0].name
  }
  # Valores sensíveis armazenados no Secret (codificados em base64 pelo opentofu):
  # Sensitive values stored in the Secret (base64 encoded by opentofu):
  data = {
    # Nome do usuário do GHCR (variável var.ghcr_username).
    # GHCR username (variable var.ghcr_username).
    username = var.ghcr_username
    # Token de acesso do GHCR (variável var.ghcr_token).
    # GHCR access token (variable var.ghcr_token).
    token    = var.ghcr_token
  }

# Storage in Opaque format, allowing flexibility for different applications to consume this data.
  type = "Opaque"
}

# Armazena as credenciais administrativas do Jenkins, necessárias para configuração inicial e autenticação do serviço.
# Stores Jenkins administrative credentials, required for initial configuration and service authentication.
resource "kubernetes_secret" "jenkins_admin" {
  metadata {
    # Nome no Kubernetes
    # Name in Kubernetes
    name      = "jenkins-admin-secret"
    namespace = kubernetes_namespace.infra.metadata[0].name
  }

  data = {
    # valor fixo "admin"
    # fixed value "admin"
    username = "admin"
    # valor definido em var.jenkins_admin_password
    # value set in var.jenkins_admin_password
    password = var.jenkins_admin_password
  }
  # Armazenamento em formato Opaque, permitindo flexibilidade para diferentes aplicações consumirem esses dados.
  # Storage in Opaque format, allowing flexibility for different applications to consume this data.
  type = "Opaque"
}
