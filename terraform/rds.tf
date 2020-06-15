resource "aws_db_instance" "dishare-db" {
  allocated_storage       = 20
  instance_class          = "db.t2.micro"
  engine                  = "MySQL"
  engine_version          = "5.7.26"
  storage_type            = "gp2"
  username                = var.aws_db_user
  password                = var.aws_db_password
  backup_retention_period = 7
  copy_tags_to_snapshot   = true
  max_allocated_storage   = 200
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.dishare-rds-sg.id]
  db_subnet_group_name    = aws_db_subnet_group.dishare-rds-subnet-group.name
  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery",
  ]

  lifecycle {
    prevent_destroy = true
  }

}

variable "aws_db_user" {}
variable "aws_db_password" {}