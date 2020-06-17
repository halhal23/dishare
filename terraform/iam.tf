data "aws_iam_policy_document" "ecs_service_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_role" {
  name               = "dishare_ecs_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_role.json
}

data "aws_iam_policy_document" "ecs_service_policy" {
  statement {
    effect = "Allow"
    resources = ["*"]
    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "ec2:Describe*",
      "ec2:AuthorizeSecurityGroupIngress"
    ]
  }
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "dishare_ecs_service_role_policy"
  policy = data.aws_iam_policy_document.ecs_service_policy.json
  role   = aws_iam_role.ecs_role.id
}


resource "aws_iam_role" "ecs_execution_role" {
  name               = "dishare_ecs_task_execution_role"
  assume_role_policy = file("./policies/ecs-task-execution-role.json")
}
resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = "dishare_ecs_execution_role_policy"
  policy = file("./policies/ecs-execution-role-policy.json")
  role   = aws_iam_role.ecs_execution_role.id
}

/*  タスクが RDS へアクセスできるためのポリシー*/
resource "aws_iam_role_policy" "task-rds-policy" {
  name   = "task-rds-policy"
  policy = file("./policies/ecs-task-execution-rds-policy.json")
  role   = aws_iam_role.ecs_execution_role.id
}
