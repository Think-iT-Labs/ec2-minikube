output "kubeconfig_export" {
  description = "Command that needs to be run in order for your kubectl to point to the minikube"
  value       = module.aws_ec_kube_cluster.kubeconfig_command
}

output "kube_public_ip" {
  description = "MiniKube instance public ip address"
  value       = module.aws_ec_kube_cluster.minikub_public_ip
}
