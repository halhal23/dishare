/* security group for RDB */
resource "aws_security_group" "dishare-rds-sg" {
  description = "RDS security group for Dishare"
  name        = "dishare-rds-sg"
  vpc_id      = aws_vpc.dishare-vpc.id
}

/* security group for ALB */
resource "aws_security_group" "dishare-alb-sg" {
  name        = "dishare-alb-sg"
  description = "ALB security group for Dishare"
  vpc_id      = aws_vpc.dishare-vpc.id
}

/* Security Group for ECS service */
resource "aws_security_group" "dishare-ecs-service-sg" {
  vpc_id      = aws_vpc.dishare-vpc.id
  name        = "dishare-ecs-service-sg"
  description = "ECS service security group for Dishare"
}

/* Security Group for ECS instance */
# resource "aws_security_group" "dishare-ecs-instance-sg" {
#   vpc_id      = aws_vpc.dishare-vpc.id
#   name        = "dishare-ecs-instance-sg"
#   description = "ECS service security group for Dishare"
# }