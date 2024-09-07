resource "aws_instance" "TfTest" {
  ami                    = data.aws_ami.AmzLinux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.PublicSub.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "tf-test"
  }
  iam_instance_profile = aws_iam_instance_profile.Ec2Profile.name
  user_data            = file("${path.module}/data-script.sh")
}

resource "aws_iam_instance_profile" "Ec2Profile" {
  name = "Ec2Profile"
  role = aws_iam_role.Ec2Role.name
}

