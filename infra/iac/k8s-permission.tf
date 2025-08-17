# Cria uma ServiceAccount chamada jenkins-sa no namespace infra.
# Essa conta de serviço será usada pelo Jenkins para autenticar-se no cluster e realizar operações em nome dele.

# Create a ServiceAccount called jenkins-sa in the infra namespace.
# This service account will be used by Jenkins to authenticate to the cluster and perform operations on its behalf.
resource "kubernetes_service_account" "jenkins_sa" {
  metadata {
    name      = "jenkins-sa"
    namespace = "infra"
  }
}

# Cria uma ClusterRole chamada jenkins-cluster-admin.
resource "kubernetes_cluster_role" "jenkins_cluster_admin" {
  metadata {
    name = "jenkins-cluster-admin"
  }

  rule {
    # todos os grupos da API Kubernetes.
    # all Kubernetes API groups.
    api_groups = ["*"] 
    # todos os tipos de recursos (pods, deployments, services, etc).
    # all types of resources (pods, deployments, services, etc).
    resources  = ["*"]
    # todas as ações (get, list, watch, create, update, delete...).
    # all actions (get, list, watch, create, update, delete...).
    verbs      = ["*"]
  }
}

# Esse código dá ao Jenkins um usuário (ServiceAccount) com poderes administrativos completos no Kubernetes. 
# Isso é usado, por exemplo, quando o Jenkins precisa criar, atualizar e deletar recursos no cluster (CI/CD 
# pipelines que deployam aplicações).

# This code gives Jenkins a user (ServiceAccount) with full administrative powers in Kubernetes.
# This is used, for example, when Jenkins needs to create, update, and delete resources in the cluster (CI/CD
# pipelines that deploy applications).
resource "kubernetes_cluster_role_binding" "jenkins_cluster_admin_binding" {
  metadata {
    name = "jenkins-cluster-admin-binding"
  }

# Diz qual papel (role) vai ser associado
# Tells which role will be associated
  role_ref {
# grupo da API responsável por RBAC.
# API group responsible for RBAC.
    api_group = "rbac.authorization.k8s.io"
# o tipo do role sendo referenciado (neste caso, um ClusterRole, que vale para o cluster inteiro, e não apenas para um namespace).
# the type of the role being referenced (in this case, a ClusterRole, which applies to the entire cluster, not just a namespace).
    kind      = "ClusterRole"
# pega o nome do ClusterRole que você definiu anteriormente
# get the name of the ClusterRole you defined earlier
    name      = kubernetes_cluster_role.jenkins_cluster_admin.metadata[0].name
  }

  # Define quem (qual entidade) terá as permissões.
  # Defines who (which entity) will have the permissions.
  subject {
  # o sujeito é uma conta de serviço.
  # the subject is a service account.
    kind      = "ServiceAccount"
  # o nome da ServiceAccount alvo (no caso, a jenkins sa)
  # the name of the target ServiceAccount (in this case, jenkins_sa)
    name      = kubernetes_service_account.jenkins_sa.metadata[0].name
  # o namespace onde está a ServiceAccount.
  # the namespace where the ServiceAccount is located.
    namespace = kubernetes_service_account.jenkins_sa.metadata[0].namespace
  }
}
