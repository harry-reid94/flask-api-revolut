resource "aws_iam_role" "role" {
  name               = "flask-role"
  assume_role_policy = data.aws_iam_policy_document.role_policy.json
}

resource "aws_iam_role_policy_attachment" "role_policy" {
  count = length(var.role_policy_arns)

  role       = aws_iam_role.role.name
  policy_arn = element(var.role_policy_arns, count.index)
}