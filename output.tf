output "kubeconfig_command" {
  description = "Command that needs to be run in order for your kubectl to point to the minikube"
  value       = "export KUBECONFIG=${abspath("${var.kubeconfig_output_location}")}"
}

output "minikub_public_ip" {
  description = "MiniKube instance public ip address"
  value       = aws_eip.instance_elastic_ip.public_ip
}
