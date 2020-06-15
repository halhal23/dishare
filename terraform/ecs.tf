/*====
ECS cluster
======*/
resource "aws_ecs_cluster" "dishare-ecs-cluster" {
  name = "dishare-ecs-cluster"
}

/*====
Cloudwatch Log Group
======*/

resource "aws_cloudwatch_log_group" "dishare-cloudwatch" {
  name = "dishare-cloudwatch"

  tags = {
    # Environment = var.environment
    Application = "dishare-ecs"
  }
}

/*====
ECS task definitions
======*/

/* the task definition for the web service */
data "template_file" "dishare_task_container" {
  template = file("./tasks/dishare_task_definition.json")

  vars = {
    nuxt_image      = "${var.nuxt_image}"
    gnavi_api_key      = "${var.gnavi_api_key}"
    gmap_api_key      = "${var.gmap_api_key}"

    rails_image      = "${var.rails_image}"
    db_database      = "${var.db_database}"
    db_host      = "${var.db_host}"
    db_username      = "${var.db_username}"
    db_password      = "${var.db_password}"
    rails_master_key = "${var.rails_master_key}"
    log_group       = "${aws_cloudwatch_log_group.dishare-cloudwatch.name}"
  }
}

resource "aws_ecs_task_definition" "dishare-task" {
  family                   = "dishare-task"
  container_definitions    = data.template_file.dishare_task_container.rendered
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_execution_role.arn
}


/* ファミリーを指定するだけで、そのファミリーの最新のACTIVEリビジョンを見つけることができる。 
data "aws_ecs_task_definition" "dishare-task" {
  depends_on = [aws_ecs_task_definition.dishare-task]
  task_definition = aws_ecs_task_definition.dishare-task.family
}

resource "aws_ecs_service" "dishare-ecs-service" {
  name            = "dishare-ecs-service"
  task_definition = "${aws_ecs_task_definition.dishare-task.family}:${max("${aws_ecs_task_definition.dishare-task.revision}", "${data.aws_ecs_task_definition.dishare-task.revision}")}"
  desired_count   = 1
  launch_type     = "EC2"
  cluster         = aws_ecs_cluster.dishare-ecs-cluster.id
  depends_on      = [
    aws_iam_role_policy.ecs_service_role_policy,
    aws_lb_target_group.dishare_alb_tg
  ]
  iam_role = ""
  network_configuration {
    security_groups = [
      aws_security_group.dishare-ecs-service-sg.id
    ]
    subnets         = [
      aws_subnet.dishare-public-sb-1a.id,
      aws_subnet.dishare-public-sb-1c.id
    ]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.dishare_alb_tg.arn
    container_name   = "nuxt-container"
    container_port   = "8080"
  }
}
*/

variable "log_group" {}
variable "nuxt_image" {}
variable "gnavi_api_key" {}
variable "gmap_api_key" {}
variable "rails_image" {}
variable "db_database" {}
variable "db_host" {}
variable "db_username" {}
variable "db_password" {}
variable "rails_master_key" {}

