variable "region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "kubeconfig_output_location" {
  type        = string
  description = "KubeConfig file Location (relative path)"
}

variable "minikube_instance_name" {
  type        = string
  description = "Minikube EC2 Instance name"
  default     = "minikube-on-ec2"
}

variable "aws_cli_profile" {
  type        = string
  description = "AWS CLI configuration profile to use (empty for default)"
}
