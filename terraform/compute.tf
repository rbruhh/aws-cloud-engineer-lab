
# -------------------------
# Bastion Host (Public)
# -------------------------
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = aws_key_pair.cloudlab.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_ssm_profile.name

  tags = {
    Name = "cloudlab-bastion"
  }
}
# -------------------------
# Launch Template for App
# -------------------------
resource "aws_launch_template" "app_lt" {
  name_prefix   = "cloudlab-app-lt-"
  image_id      = data.aws_ami.al2023.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = aws_key_pair.cloudlab.key_name

iam_instance_profile {
  name = aws_iam_instance_profile.ec2_ssm_profile.name
}

  user_data = base64encode(<<-EOF
              #!/bin/bash
              dnf -y update
              dnf -y install nginx
              systemctl enable nginx
              systemctl start nginx
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "cloudlab-asg-instance"
    }
  }
}

# -------------------------
# Latest Amazon Linux 2023 AMI (x86_64)
# -------------------------
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
# -------------------------
# SSH Key Pair
# -------------------------
resource "aws_key_pair" "cloudlab" {
  key_name   = "cloudlab-key"
  public_key = file("C:/Users/rlbra/.ssh/cloudlab.pub")
}