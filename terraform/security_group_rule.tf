/* security group rule for RDS */
resource "aws_security_group_rule" "dishare-rds-sg-rule1" {
  description       = "dishare rds sg rule"
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0", "0.0.0.0/16"]
  security_group_id = aws_security_group.dishare-rds-sg.id
}
resource "aws_security_group_rule" "dishare-rds-sg-rule2" {
  description       = "dishare rds sg rule2"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dishare-rds-sg.id
}
resource "aws_security_group_rule" "dishare-rds-sg-rule3" {
  description       = "dishare rds sg rule3"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.dishare-rds-sg.id
}


/* security group rule for ALB */
resource "aws_security_group_rule" "dishare-alb-sg-rule1" {
  description       = "dishare-alb-sg-rule1"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dishare-alb-sg.id
}
resource "aws_security_group_rule" "dishare-alb-sg-rule2" {
  description       = "dishare-alb-sg-rule2"
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dishare-alb-sg.id
}
resource "aws_security_group_rule" "dishare-alb-sg-rule3" {
  description       = "dishare-alb-sg-rule3"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dishare-alb-sg.id
}
resource "aws_security_group_rule" "dishare-alb-sg-rule4" {
  description       = "dishare-alb-sg-rule4"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dishare-alb-sg.id
}

/* Security Group rule for ECS service */
resource "aws_security_group_rule" "dishare-ecs-service-sg-rule1" {
  description       = "dishare-ecs-service-sg-rule1"
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dishare-ecs-service-sg.id
}
resource "aws_security_group_rule" "dishare-ecs-service-sg-rule2" {
  description       = "dishare-ecs-service-sg-rule2"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dishare-ecs-service-sg.id
}
resource "aws_security_group_rule" "dishare-ecs-service-sg-rule3" {
  description       = "dishare-ecs-service-sg-rule3"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dishare-ecs-service-sg.id
}
resource "aws_security_group_rule" "dishare-ecs-service-sg-rule4" {
  description       = "dishare-ecs-service-sg-rule4"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dishare-ecs-service-sg.id
}

/* Security Group rule for ECS instance */
resource "aws_security_group_rule" "dishare-ecs-instance-sg-rule1" {
  description       = "dishare-ecs-instance-sg-rule1"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id  = aws_security_group.dishare-alb-sg.id
  security_group_id = aws_security_group.dishare-ecs-instance-sg.id
}
resource "aws_security_group_rule" "dishare-ecs-instance-sg-rule2" {
  description       = "dishare-ecs-instance-sg-rule2"
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dishare-ecs-instance-sg.id
}