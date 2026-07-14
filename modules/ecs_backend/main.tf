resource "aws_ecs_cluster" "cluster" {
  name = "ecs-cluster"
}

resource "aws_ecs_task_definition" "backend_task" {
  family                   = "backend-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "backend-api-container"
      image     = "localhost:4566/mern-backend-api:latest"
      essential = true
      portMappings = [
        {
          containerPort = 5001
          hostPort      = 5001
        }
      ]
      environment = [
        { name = "DB_HOST", value = var.db_host },
        { name = "DB_USER", value = "admin" },
        { name = "DB_PASSWORD", value = var.db_password },
        { name = "DB_NAME", value = "mydb" },
        { name = "PORT", value = "5001" }
      ]
    }
  ])
}

resource "aws_ecs_service" "backend_service" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.backend_task.arn
  desired_count   = 1
  launch_type     = "EC2"
  network_configuration {
    subnets          = ["subnet-12345678"] 
    security_groups  = ["sg-12345678"]
    assign_public_ip = false
  }
}