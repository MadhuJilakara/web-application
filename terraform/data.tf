data "aws_ami" "AmzLinux" {
  most_recent = true

  filter {
    name   = "name"
    # values = ["al2023-ami-2023.5.20240903.0-kernel-6.1-x86_64"]
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20240903.0-x86_64-gp2"]
  }
}
