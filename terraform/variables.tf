variable "role_principal_arns" {
  default = ["499101402367"]
  type        = list(string)
  description = "ARNs of accounts, groups, or users with the ability to assume this role."
}

variable "role_policy_arns" {
  default = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  type        = list(string)
  description = "List of ARNs of policies to be associated with the created IAM role"
}

variable "role_name" {
  default = "flask-role"
  type        = string
}

variable "ecs_node_count" {
  default = 6
  type        = number
}