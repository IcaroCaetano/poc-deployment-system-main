# Cria um cluster Kubernetes local usando Kind (Kubernetes in Docker).
# O nome do cluster é definido usando uma variável var.prefix seguida de poc-kind-cluster.

# Creates a local Kubernetes cluster using Kind (Kubernetes in Docker).
# The cluster name is defined using a var.prefix variable followed by poc-kind-cluster.
resource "kind_cluster" "default" {
  name = "${var.prefix}poc-kind-cluster"
}

# Namespace infra → onde ficarão serviços de infraestrutura (monitoramento, CI/CD).
# Infra namespace → where infrastructure services (monitoring, CI/CD) will be located.
resource "kubernetes_namespace" "infra" {
  metadata { name = "infra" }
}

# Namespace apps → onde rodarão as aplicações da sua solução.
# Namespace apps → where your solution's applications will run.
resource "kubernetes_namespace" "apps" {
  metadata { name = "apps" }
}

# Instala Prometheus (monitoramento) no namespace infra.
# Install Prometheus (monitoring) in the infra namespace.
resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = kubernetes_namespace.infra.metadata[0].name
  # Usa o repositório oficial da comunidade.
  # Use the official community repository.
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  # Versão do chart
  # Chart version
  version    = "27.14.0"
}

# Instala Grafana no namespace infra.
# Usa configurações extras do arquivo grafana-values.yaml

# Install Grafana in the infra namespace.
# Use extra configuration from the grafana-values.yaml file
resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = kubernetes_namespace.infra.metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  # Versão do chart
  # Chart version
  version    = "9.0.0"
  values = [
    file("${path.module}/grafana-values.yaml")
  ]
}

# Instala Jenkins no namespace infra.
# Installs Jenkins in the infra namespace.
resource "helm_release" "jenkins" {
  name       = "jenkins"
  namespace  = kubernetes_namespace.infra.metadata[0].name
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  # Versão do chart
  # Chart version
  version    = "5.8.73"
  create_namespace = false
# Usa configurações definidas no arquivo jenkins-values.yaml. 
# Uses settings defined in the jenkins-values.yaml file.
  values = [
    file("${path.module}/jenkins-values.yaml")
  ]
  # depends_on → garante que o Jenkins só será instalado depois que o cluster Kind estiver criado.
  # depends_on → ensures that Jenkins will only be installed after the Kind cluster is created.
  depends_on = [kind_cluster.default]
}
