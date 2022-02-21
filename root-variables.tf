variable "kubconfig_location" {
  description = "Location of the exported cluster's kubeconfig"
  type        = string
  default     = "./k8s/kubeconfig"

}

variable "cluster_instance_type" {
  description = "Type of the cluster's nodes"
  type        = string
  default     = "t3.large"
}

variable "region" {
  description = "Cluster's aws region"
  type        = string
  default     = "us-east-1"

}

