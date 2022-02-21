variable "kubeconfig_output_location" {
  description = "KubeConfig file Location"
  type        = string

}
variable "aws_region" {
  description = "the aws region where to deploy the cluster"
  type        = string
}

variable "instance_type" {
  description = "Ec2 instance type to use "
  type        = string
}



