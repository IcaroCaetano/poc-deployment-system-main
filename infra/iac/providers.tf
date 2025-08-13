##Permite criar e gerenciar clusters Kind (Kubernetes IN Docker).
#É usado no recurso kind_cluster para subir um cluster local de testes.
#Não possui parâmetros obrigatórios, pois as configurações vêm do próprio recurso.
provider "kind" {}

##Conecta o OpenTofu diretamente ao cluster Kubernetes criado.
#Usa o kubeconfig_path gerado pelo recurso kind_cluster para autenticação.
#Permite criar recursos como:
#Namespaces
#Deployments
#Services
#ConfigMaps, etc.
provider "kubernetes" {
  config_path = kind_cluster.default.kubeconfig_path
}

##Permite instalar e gerenciar pacotes Helm dentro do cluster.
#O config_path aponta para o mesmo kubeconfig, garantindo que o Helm se conecte ao cluster recém-criado.
#Usado para instalar aplicações como Grafana, Prometheus, Jenkins.
provider "helm" {
  kubernetes {
    config_path = kind_cluster.default.kubeconfig_path
  }
}