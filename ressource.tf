module "aws_ec_kube_cluster" {
  source                     = "./minikube_module"
  kubeconfig_output_location = var.kubconfig_location
  aws_region                 = var.region
  instance_type              = var.cluster_instance_type
}
