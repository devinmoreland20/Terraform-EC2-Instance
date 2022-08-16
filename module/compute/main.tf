# ------- module/main.tf
resource "aws_instance" "app_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.sg]
  user_data              = var.user_data
  iam_instance_profile   = var.iam_instance_profile
  key_name               = data.aws_key_pair.oregon.key_name
  tags = {
    Name = "${var.tag_name}instance"
  }
}
data "aws_key_pair" "oregon" {
  key_name = "Oregon"
}
