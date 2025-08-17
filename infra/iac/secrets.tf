# Este arquivo define Secrets no Kubernetes usando opentofu, que armazenam informações sensíveis, como credenciais, de forma segura.
# Secret que armazena credenciais para acessar o GitHub Container Registry (GHCR) a partir do Jenkins

# This file defines Secrets in Kubernetes using opentofu, which store sensitive information, such as credentials, securely.
Secret that stores credentials to access GitHub Container Registry (GHCR) from Jenkins
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

  type = "Opaque"
}

resource "kubernetes_secret" "jenkins_admin" {
  metadata {
    name      = "jenkins-admin-secret"
    namespace = kubernetes_namespace.infra.metadata[0].name
  }

  data = {
    username = "admin"
    password = var.jenkins_admin_password
  }

  type = "Opaque"
}
