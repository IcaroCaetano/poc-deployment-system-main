# ------------------------------------------------------------
# Variable: prefix
# ------------------------------------------------------------
# Tipo: string
# Default: ""
# Descrição:
#   Essa variável é utilizada para adicionar um prefixo
#   personalizado ao nome dos recursos criados.
#   É útil principalmente em testes ou em ambientes
#   diferentes (ex: dev, stage, prod), permitindo
#   diferenciar os recursos por nome.

# ------------------------------------------------------------
# Variable: prefix
# ------------------------------------------------------------
# Type: string
# Default: ""
# Description:
# This variable is used to add a custom prefix
# to the name of created resources.
# It is especially useful in testing or in different environments
# (e.g., dev, stage, prod), allowing
# you to differentiate resources by name.
variable "prefix" {
  type        = string
  default     = ""
  description = "Used on tests to change the name of the resources"
}

# ------------------------------------------------------------
# Variable: ghcr_username
# ------------------------------------------------------------
# Tipo: string
# Default: "icaetano"
# Descrição:
#   Nome de usuário do GitHub Container Registry (GHCR).
#   Essa variável será usada para autenticação em repositórios
#   de contêiner hospedados no GHCR.

# -----------------------------------------------------------
# Variable: ghcr_username
# -----------------------------------------------------------------
# Type: string
# Default: "icaetano"
# Description:
# GitHub Container Registry (GHCR) username.
# This variable will be used to authenticate to container repositories
# hosted on GHCR.
variable "ghcr_username" {
  type        = string
  description = "GitHub Container Registry username"
  default     = "icaetano"
}


# -----------------------------------------------------------
# Variável: ghcr_token
# -----------------------------------------------------------------
# Tipo: string
# Sensível: true (o valor não será exibido em logs/saídas)
# Descrição:
# Token de autenticação para acessar o GitHub Container
# Registro (GHCR). Esta é uma credencial sensível e, portanto,
# marcada como `sensitive = true` para proteger as informações.

# -----------------------------------------------------------
# Variable: ghcr_token
# -----------------------------------------------------------------
# Type: string
# Sensitive: true (value will not be displayed in logs/output)
# Description:
# Authentication token to access the GitHub Container
# Registry (GHCR). This is a sensitive credential, and is therefore
# marked as `sensitive = true` to protect the information.
variable "ghcr_token" {
  type        = string
  description = "GitHub Container Registry token"
  sensitive   = true
}



# ------------------------------------------------------------
# Variable: jenkins_admin_password
# ------------------------------------------------------------
# Tipo: string
# Default: "admin"
# Sensitive: true
# Descrição:
#   Senha do usuário administrador do Jenkins.
#   Essa senha será usada para login inicial no Jenkins
#   após o provisionamento. Como contém credenciais,
#   está marcada como `sensitive = true`.
#   Recomenda-se alterar o valor default em ambientes reais.

# ------------------------------------------------------------
# Variable: jenkins_admin_password
# ------------------------------------------------------------
# Type: string
# Default: "admin"
# Sensitive: true
# Description:
# Password for the Jenkins administrator user.
# This password will be used for the initial login to Jenkins
# after provisioning. Because it contains credentials,
# it is marked as `sensitive = true`.
# It is recommended to change the default value in real environments.
variable "jenkins_admin_password" {
  type        = string
  description = "Jenkins admin password"
  sensitive   = true
  default     = "admin"
}
