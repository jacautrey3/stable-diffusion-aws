#data source for aws_ami id for latest Deep Learnnig OSS NVIDIA GPU AMI PyTorch 1.13.1
data "aws_ami" "latest_amazon_linux_2_dl" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Deep Learning OSS Nvidia Driver AMI GPU PyTorch*"]
  }


  owners = ["898082745236"]
}


#Create EC2 Instance with 32 GB of storage
resource "aws_instance" "sd_ec2" {
  ami             = data.aws_ami.latest_amazon_linux_2_dl.id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.stable_diffusion_sg.name]
  root_block_device {
    volume_size = 80
  }
  tags = {
    Name    = "stable_diffusion"
    Project = "stable_diffusion"
  }
}

#Create security group 
resource "aws_security_group" "stable_diffusion_sg" {
  name        = var.sg_name
  description = "Allow inbound ports 22, 8080"
  vpc_id      = var.vpc_id

  tags = {
    Name    = "stable_diffusion"
    Project = "stable_diffusion"
  }

  #Allow incoming TCP requests on port 22 from any IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Allow incoming TCP requests on port 443 from any IP
  ingress {
    description = "Allow HTTPS Traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Allow incoming TCP requests on port 80 from any IP
  ingress {
    description = "Allow HTTP Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
