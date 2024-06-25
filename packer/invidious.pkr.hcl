packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "invidious" {
  ami_name      = "myhomelab-invidious-{{timestamp}}"
  tags = {
    Name = "myhomelab-invidious"
  }
  spot_instance_types  = ["t3.medium"]
  spot_price = "0.02"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-2.0.*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["137112412989"]
  }
  ssh_username         = "ec2-user"
  ssh_interface        = "session_manager"
  communicator         = "ssh"
  iam_instance_profile = "ec2-ssm-core"
  ami_regions = ["us-east-1"]
}

build {
  name    = "myhomelab-invidious"
  sources = [
    "source.amazon-ebs.invidious"
  ]
  
  provisioner "shell" {
    inline = [
      "curl -fsSL https://crystal-lang.org/install.sh | sudo bash",
      "sudo yum install -y openssl-devel libevent-devel libxml2-devel libyaml-devel gmp-devel readline-devel postgresql librsvg2-devel sqlite-devel zlib-devel gcc  open-sans-fonts git",
      "sudo useradd -m invidious",
      "sudo runuser -l invidious -c 'cd /home/invidious/;git clone https://github.com/iv-org/invidious && cd invidious && make'",
    ]
  }
}