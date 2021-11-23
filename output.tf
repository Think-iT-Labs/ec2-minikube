output "kubeconfig_command" {
  value = "export KUBECONFIG=${abspath("${var.kubeconfig_output_location}")}"
}
