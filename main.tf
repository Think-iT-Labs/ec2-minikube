data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "aws_keypair" {
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_security_group" "allow_kube_api_server" {
  name        = "allow_kube_api_server"
  description = "Allow TLS inbound traffic"

  ingress = [
    {
      description      = "allow ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "TCP"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "allow api server"
      from_port        = 8443
      to_port          = 8443
      protocol         = "TCP"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "allow all"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "allow_kube_api_server"
  }
}

resource "aws_instance" "minikube_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.large"
  key_name      = aws_key_pair.aws_keypair.key_name

  security_groups = [aws_security_group.allow_kube_api_server.name]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.private_key.private_key_pem
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/setup-minikube.sh"
  }
}

resource "null_resource" "download_kubeconfig" {
  depends_on = [
    aws_instance.minikube_instance
  ]
  triggers = {
    "timestamp" = timestamp()
  }
  provisioner "local-exec" {
    command = "${path.module}/scripts/download_kubeconfig.sh \"$PRIVATE_KEY\" ubuntu ${aws_instance.minikube_instance.public_ip} ${var.kubeconfig_output_location}"
    environment = {
      PRIVATE_KEY = tls_private_key.private_key.private_key_pem
    }
  }
}
