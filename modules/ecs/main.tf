resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.application}-${var.environment}-ecs-cluster"
}

resource "aws_ecs_service" "ecs_service" {
  name = "${var.application}-${var.environment}-ecs-service"
  cluster = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.id
}

resource "aws_ecs_task_definition" "task_definition" {
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "service-first"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 80
        }
      ]
    }
  ])
  family                = "service"
}
