# Exibe o nome do cluster Kind criado.
# Útil para identificar o cluster ativo.

# Displays the name of the created Kind cluster.
# Useful for identifying the active cluster.
output "cluster_name" {
  description = "Name of the Kind cluster"
  value       = kind_cluster.default.name
}

# Informa o caminho para o kubeconfig, necessário para interagir com o cluster.
# Marcado como sensitive = true, ou seja, não será mostrado no log por segurança

# Provides the path to kubeconfig, which is required to interact with the cluster.
# Marked as sensitive = true, meaning it will not be displayed in the log for security reasons.
output "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  value       = kind_cluster.default.kubeconfig_path
  sensitive   = true
}

# Fornece o comando para acessar a interface do Grafana localmente:
# Abre o Grafana em http://localhost:3000.

# Provides the command to access the Grafana interface locally:
# Opens Grafana at http://localhost:3000
output "grafana_port_forward" {
  description = "Command to port-forward Grafana"
  value       = "kubectl port-forward -n infra svc/grafana 3000:80"
}

# Fornece o comando para acessar o Jenkins localmente:
# Abre o Jenkins em http://localhost:8080.

# Provides the command to access Jenkins locally:
# Open Jenkins at http://localhost:8080.
output "jenkins_port_forward" {
  description = "Command to port-forward Jenkins"
  value       = "kubectl port-forward -n infra svc/jenkins 8080:8080"
}
