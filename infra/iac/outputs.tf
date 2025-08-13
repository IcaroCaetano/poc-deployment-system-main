##Exibe o nome do cluster Kind criado.
#Útil para identificar o cluster ativo.
output "cluster_name" {
  description = "Name of the Kind cluster"
  value       = kind_cluster.default.name
}
##Informa o caminho para o kubeconfig, necessário para interagir com o cluster.
#Marcado como sensitive = true, ou seja, não será mostrado no log por segurança
output "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  value       = kind_cluster.default.kubeconfig_path
  sensitive   = true
}

##Fornece o comando para acessar a interface do Grafana localmente:
#Abre o Grafana em http://localhost:3000.
output "grafana_port_forward" {
  description = "Command to port-forward Grafana"
  value       = "kubectl port-forward -n infra svc/grafana 3000:80"
}

##Fornece o comando para acessar o Jenkins localmente:
#Abre o Jenkins em http://localhost:8080.
output "jenkins_port_forward" {
  description = "Command to port-forward Jenkins"
  value       = "kubectl port-forward -n infra svc/jenkins 8080:8080"
}