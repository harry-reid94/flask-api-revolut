data "aws_availability_zones" "available_zones" {
  state = "available"
}

data "aws_iam_policy_document" "role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.role_principal_arns
    }
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    principals {
      type        = "Service"
      identifiers = ["elasticfilesystem.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_role" "role" {
  name = "flask-role"
}