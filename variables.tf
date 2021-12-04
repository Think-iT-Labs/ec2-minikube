variable "kubeconfig_output_location" {
  type        = string
  description = "KubeConfig file Location"
}

variable "minikube_instance_name" {
  type        = string
  description = "Minikube EC2 Instance name"
  default     = "minikube-on-ec2"
}
