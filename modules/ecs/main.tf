module "ecs-role" {
  source      = "./role"
  application = var.application
  environment = var.environment
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.application}-${var.environment}-ecs-cluster"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.application}-${var.environment}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task_definition.id

  network_configuration {
    subnets         = var.ecs_subnets_ids
    security_groups = [aws_security_group.ecs_sg.id]
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = module.ecs-role.ecs_task_execution_role_arn
  container_definitions    = jsonencode(
    [
      {
        name         = "first"
        image        = var.image_url
        cpu          = 10
        memory       = 512
        essential    = true
        portMappings = [
          {
            containerPort = 8080
            hostPort      = 8080
            protocol      = "tcp"
          }
        ]
        environment = [
          {
            name  = "ENVIRONMENT"
            value = var.environment
          }
        ]
      }
    ])
  family = "service"


}

resource "aws_security_group" "ecs_sg" {
  name   = "${var.application}-${var.environment}-ecs-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ecs_inbound_traffic" {
  from_port         = -1
  protocol          = -1
  security_group_id = aws_security_group.ecs_sg.id
  to_port           = -1
  type              = "ingress"
  cidr_blocks       = ["10.0.0.0/16"]
}

resource "aws_security_group_rule" "ecs_outbound_traffic" {
  from_port         = -1
  protocol          = -1
  security_group_id = aws_security_group.ecs_sg.id
  to_port           = -1
  type              = "egress"
  cidr_blocks       = ["10.0.0.0/16"]
}
