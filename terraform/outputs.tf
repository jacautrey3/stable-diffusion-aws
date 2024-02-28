output "url-stable_diffusion" {
  value = aws_instance.sd_ec2.public_ip
}

output "aws_ami_name" {
  value = data.aws_ami.latest_amazon_linux_2_dl.name
}

output "aws_instance_storage_siez" {
  value = aws_instance.sd_ec2.root_block_device.0.volume_size
}
