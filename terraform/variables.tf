variable "aws_region" {
  default = "us-west-1"
}

variable "instance_type" {
  default = "t2.2xlarge"
}

variable "key_name" {
  default = "stable-diffusion-key"
}

variable "sg_name" {
  default = "stable_diffusion_sg"
}

variable "vpc_id" {
  default = "vpc-0063ef0d505b1e399"
}
