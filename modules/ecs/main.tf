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
          }
        ]
      }
    ])
  family = "service"
}
