###################################
## Virtual Machine Module - Main ##
###################################

# Create EC2 Instance
resource "aws_instance" "linux-server" {
  ami                         = data.aws_ami.server_ami.id
  instance_type               = var.linux_instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = var.linux_associate_public_ip_address
  source_dest_check           = false
  key_name                    = var.key_name
  user_data                   = file("${path.module}/aws-user-data.sh")
  
  # root disk
  root_block_device {
    volume_size           = var.linux_root_volume_size
    volume_type           = var.linux_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  # extra disk
  ebs_block_device {
    device_name           = "/dev/xvdb"
    volume_size           = var.linux_data_volume_size
    volume_type           = var.linux_data_volume_type
    encrypted             = true
    delete_on_termination = true
  }
  
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-server"
    Environment = var.app_environment
  }
}

# Create Elastic IP
resource "aws_eip" "linux-eip" {
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-eip"
    Environment = var.app_environment
  }
}

# Associate Elastic IP to Linux Server
resource "aws_eip_association" "linux-eip-association" {
  instance_id   = aws_instance.linux-server.id
  allocation_id = aws_eip.linux-eip.id
}
