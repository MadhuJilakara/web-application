data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "Ec2Role" {
  name                = "Ec2Role"
  assume_role_policy  = data.aws_iam_policy_document.instance_assume_role_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]
}

