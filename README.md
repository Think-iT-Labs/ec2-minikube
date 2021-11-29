# EC2-Minikube

## Architecture

![Architecture](images/architecture.drawio.png)

## Usage

### Provisioning the Infrastructure

```bash
terraform apply
```

### Connecting to the k8s cluster

You can export the Kubeconfig file using this helper
```bash
$(terraform output -raw kubeconfig_command)
```

### Checking the connection

```bash
kubectl cluster-info
```
