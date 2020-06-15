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
data "template_file" "dishare_nuxt_container" {
  template = file("./tasks/dishare_nuxt_definition.json")

  vars = {
    nuxt_image      = "${var.nuxt_image}"
    gnavi_api_key      = "${var.gnavi_api_key}"
    gmap_api_key      = "${var.gmap_api_key}"
    log_group       = "${aws_cloudwatch_log_group.dishare-cloudwatch.name}"
  }
}
data "template_file" "dishare_rails_container" {
  template = file("./tasks/dishare_rails_definition.json")

  vars = {
    rails_image      = "${var.rails_image}"
    db_database      = "${var.db_database}"
    db_host      = "${var.db_host}"
    db_username      = "${var.db_username}"
    db_password      = "${var.db_password}"
    rails_master_key = "${var.rails_master_key}"
    log_group       = "${aws_cloudwatch_log_group.dishare-cloudwatch.name}"
  }
}

resource "aws_ecs_task_definition" "dishare-nuxt-task" {
  family                   = "dishare-nuxt-task"
  container_definitions    = data.template_file.dishare_nuxt_container.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_execution_role.arn
}
resource "aws_ecs_task_definition" "dishare-rails-task" {
  family                   = "dishare-rails-task"
  container_definitions    = data.template_file.dishare_rails_container.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_execution_role.arn
}


/* ファミリーを指定するだけで、そのファミリーの最新のACTIVEリビジョンを見つけることができる。 */
data "aws_ecs_task_definition" "dishare-nuxt-task" {
  depends_on = [aws_ecs_task_definition.dishare-nuxt-task]
  task_definition = aws_ecs_task_definition.dishare-nuxt-task.family
}
data "aws_ecs_task_definition" "dishare-rails-task" {
  depends_on = [aws_ecs_task_definition.dishare-rails-task]
  task_definition = aws_ecs_task_definition.dishare-rails-task.family
}

resource "aws_ecs_service" "dishare-nuxt-ecs-service" {
  name            = "dishare-nuxt-ecs-service"
  task_definition = "${aws_ecs_task_definition.dishare-nuxt-task.family}:${max("${aws_ecs_task_definition.dishare-nuxt-task.revision}", "${data.aws_ecs_task_definition.dishare-nuxt-task.revision}")}"
  desired_count   = 1
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.dishare-ecs-cluster.id
  depends_on      = [
    aws_iam_role_policy.ecs_service_role_policy,
    aws_lb_target_group.dishare_alb_nuxt_tg
  ]
  network_configuration {
    security_groups = [
      aws_security_group.dishare-ecs-service-sg.id
    ]
    subnets         = [
      aws_subnet.dishare-public-sb-1a.id,
      aws_subnet.dishare-public-sb-1c.id
    ]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.dishare_alb_nuxt_tg.arn
    container_name   = "nuxt-container"
    container_port   = "8080"
  }
}
resource "aws_ecs_service" "dishare-rails-ecs-service" {
  name            = "dishare-rails-ecs-service"
  task_definition = "${aws_ecs_task_definition.dishare-rails-task.family}:${max("${aws_ecs_task_definition.dishare-rails-task.revision}", "${data.aws_ecs_task_definition.dishare-rails-task.revision}")}"
  desired_count   = 1
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.dishare-ecs-cluster.id
  depends_on      = [
    aws_iam_role_policy.ecs_service_role_policy,
    aws_lb_target_group.dishare_alb_rails_tg
  ]
  network_configuration {
    security_groups = [
      aws_security_group.dishare-ecs-service-sg.id
    ]
    subnets         = [
      aws_subnet.dishare-public-sb-1a.id,
      aws_subnet.dishare-public-sb-1c.id
    ]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.dishare_alb_rails_tg.arn
    container_name   = "rails-container"
    container_port   = "3000"
  }
}


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

