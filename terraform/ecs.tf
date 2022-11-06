resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "flask-api"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = data.aws_iam_role.role.arn

  container_definitions = <<DEFINITION
[
  {
    "image": "499101402367.dkr.ecr.eu-west-1.amazonaws.com/ecr-repo-revolut:flask-image-revolut",
    "cpu": 1024,
    "memory": 2048,
    "name": "flask-container-revolut",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ],
    "mountPoints": [
          {
              "containerPath": "/flask-api-revolut/app/datastore/efs",
              "sourceVolume": "efs-flask"
          }
    ]
  }
]
DEFINITION
  
  volume {
    name      = "efs-flask"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.efs.id
      root_directory = "/"
    }
  }
}

resource "aws_ecs_cluster" "main" {
  name = "flask-ecs-cluster"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "flask-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 4
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.flask_api_sg.id]
    subnets         = aws_subnet.private_subnet.*.id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.id
    container_name   = "flask-container-revolut"
    container_port   = 5000
  }

  depends_on = [aws_lb_listener.lb_listener]
}