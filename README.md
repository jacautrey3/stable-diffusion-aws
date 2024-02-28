# stable-diffusion-aws

This repository is designed to provision an AWS instance that has stable-diffusion-webui from automatic1111. This uses the Deep Learning Amazon Linux 2 ami image without a GPU.

## Prerequisites
- AWS account
- Terraform installed
- Ansible installed

## Usage
1. Create a key-pair from AWS.
2. Clone this repository.
3. Navigate to the repository directory.
4. Navigate to the `terraform` folder and run `terraform apply` to provision the AWS instance.
5. Add the public IP address outputted from Terraform to the `ansible/hosts.yaml` file, and edit the `ansible_ssh_private_key_file` to the private key file path.
6. In the `ansible` directory, run `ansible-playbook install_stable_diffusion.yml` to install stable-diffusion-webui on the instance.
7. SSH into the instance using the provided private key.
8. In the `stable-diffusion-webui` directory, run `./webui.sh --skip-torch-cuda-test --precision full --no-half` to start the stable-diffusion-webui.
9. In a local terminal, run `ssh -i {instance-private-key} -N -L 7680:127.0.0.1:7860 ubuntu@{instance-public-ip}` to establish a secure tunnel to the web interface.

Note: Replace `{instance-private-key}` with the actual private key file path and `{instance-public-ip}` with the actual public IP address of the instance.

