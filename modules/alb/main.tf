resource "aws_alb" "ecs_alb" {
  load_balancer_type = "application"
  name               = "${var.application}-${var.environment}-alb"
  subnets            = var.alb_subnets
}

resource "aws_alb_target_group" "ecs_alb_target_group" {
  name        = "${var.application}-${var.environment}-target-group"
  target_type = "ip"
  protocol    = "HTTP"
  port        = 8080
  vpc_id      = var.vpc_id
}

resource "aws_alb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_alb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.ecs_alb_target_group.arn
    type             = "forward"
  }
}

resource "aws_alb_target_group" "target_group" {
  target_type = "ip"
  protocol    = "HTTP"
  port        = 8080
  vpc_id      = var.vpc_id
}
