##Cria um cluster Kubernetes local usando Kind (Kubernetes in Docker).
#O nome do cluster é definido usando uma variável var.prefix seguida de poc-kind-cluster.
resource "kind_cluster" "default" {
  name = "${var.prefix}poc-kind-cluster"
}

##Namespace infra → onde ficarão serviços de infraestrutura (monitoramento, CI/CD).
resource "kubernetes_namespace" "infra" {
  metadata { name = "infra" }
}

##Namespace apps → onde rodarão as aplicações da sua solução.
resource "kubernetes_namespace" "apps" {
  metadata { name = "apps" }
}

##Instala Prometheus (monitoramento) no namespace infra.
#Usa o repositório oficial da comunidade.
#Versão do chart: 27.14.0.
resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = kubernetes_namespace.infra.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "27.14.0"
}

##Instala Grafana no namespace infra.
#Usa configurações extras do arquivo grafana-values.yaml
resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = kubernetes_namespace.infra.metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "9.0.0"
  values = [
    file("${path.module}/grafana-values.yaml")
  ]
}

##Instala Jenkins no namespace infra.
#Usa configurações definidas no arquivo jenkins-values.yaml.
#depends_on → garante que o Jenkins só será instalado depois que o cluster Kind
# estiver criado.
resource "helm_release" "jenkins" {
  name       = "jenkins"
  namespace  = kubernetes_namespace.infra.metadata[0].name
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  version    = "5.8.73"
  create_namespace = false
  values = [
    file("${path.module}/jenkins-values.yaml")
  ]
  depends_on = [kind_cluster.default]
}