
########################### Region ################################
provider "aws" {
  region     = "${var.region}"
}
 
########################### Create ELB ################################
resource "aws_alb" "ecs-load-balancer" {
  name                = "${var.ecs_lb_name}-${var.environment}"
  internal            = true
  load_balancer_type  = "application"
  security_groups     = ["sg-1234567890"]
  subnets             = ["subnet-1234567890", "subnet-0987654321"]
 
  tags {
    Name = "${var.ecs_lb_name}-${var.environment}"
  }
}
 
resource "aws_lb_target_group" "ecs-target-group" {
  depends_on = ["aws_alb.ecs-load-balancer"]
  name                = "${var.aws_lb_target_group_name}-${var.environment}"
  port                = "80"
  protocol            = "HTTP"
  target_type         = "instance"
  vpc_id              = "vpc-1234567890"
 
  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }
 
  tags {
    Name = "${var.aws_lb_target_group_name}-${var.environment}"
  }
}
 
resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    target_group_arn = "${aws_lb_target_group.ecs-target-group.arn}"
    type             = "forward"
  }
}
 
########################### Create Launch Configuration ################################
resource "aws_launch_configuration" "ecs-launch-configuration" {
  name                        = "${var.aws_launch_configuration_name}-${var.environment}"
  image_id                    = "ami-fad25980"
  instance_type               = "m5.large"
  iam_instance_profile        = "org-cloud-ec2-developer-role-profile"
 
  root_block_device {
    volume_type = "standard"
    volume_size = 100
    delete_on_termination = true
  }
 
  lifecycle {
    create_before_destroy = true
  }
 
  security_groups             = ["sg-1234567890"]
  associate_public_ip_address = "true"
  key_name                    = "org-example-kp-service"
  user_data                   = <<EOF
                                  #!/bin/bash
                                  echo ECS_CLUSTER=${var.ecs_cluster} >> /etc/ecs/ecs.config
                                  EOF
}
 
########################### Create Autoscale Configuration ################################
resource "aws_autoscaling_group" "ecs-autoscaling-group" {
  name                        = "${var.aws_autoscaling_group_name}-${var.environment}"
  max_size                    = "3"
  min_size                    = "1"
  desired_capacity            = "2"
  vpc_zone_identifier         = ["subnet-1234567890", "subnet-0987654321"]
  launch_configuration        = "${aws_launch_configuration.ecs-launch-configuration.name}"
  health_check_type           = "ELB"
}
 
########################### Create Cluster ################################
resource "aws_ecs_cluster" "org-example-ecs-cluster" {
  name = "${var.ecs_cluster}"
}
 
########################### Create Task definition ################################
data "aws_ecs_task_definition" "org-example-task-definition" {
  depends_on = [ "aws_ecs_task_definition.org-example-task-definition" ]
  task_definition = "${aws_ecs_task_definition.org-example-task-definition.family}"
}
 
resource "aws_ecs_task_definition" "ids-sevice-task" {
  family                 = "${var.aws_ecs_task_definition_name}-${var.environment}"
  task_role_arn          = "arn:aws:iam::1234567890:role/org-cloud-ec2-developer-role-profile"
  execution_role_arn     = "arn:aws:iam::1234567890:role/org-cloud-ec2-developer-role-profile"
  network_mode           = "bridge"
  container_definitions  = <<DEFINITION
[
   {
      "dnsSearchDomains": null,
      "logConfiguration": null,
      "entryPoint": [],
      "portMappings": [
        {
          "hostPort": 80,
          "protocol": "tcp",
          "containerPort": 8080
        }
      ],
      "command": ["sh -c 'echo \"Hello World\"'"],
      "linuxParameters": null,
      "cpu": 10,
      "environment": [],
      "resourceRequirements": null,
      "ulimits": null,
      "dnsServers": null,
      "mountPoints": [],
      "workingDirectory": null,
      "secrets": null,
      "dockerSecurityOptions": null,
      "memory": 800,
      "memoryReservation": null,
      "volumesFrom": [],
      "stopTimeout": null,
      "image": "08789734324.dkr.ecr.us-east-1.amazonaws.com/org.example/nodejs/myapp:latest",
      "startTimeout": null,
      "dependsOn": null,
      "disableNetworking": null,
      "interactive": null,
      "healthCheck": null,
      "essential": true,
      "links": [],
      "hostname": null,
      "extraHosts": null,
      "pseudoTerminal": null,
      "user": null,
      "readonlyRootFilesystem": null,
      "dockerLabels": null,
      "systemControls": null,
      "privileged": null,
      "name": "${var.container_definitions_name}-${var.environment}"
    }
]
DEFINITION
}
 
########################### Create Service ################################
resource "aws_ecs_service" "org-ecs-service" {
  depends_on = ["aws_alb_listener.alb-listener"]
  name            = "${var.aws_ecs_service_name}-${var.environment}"
  iam_role        = "org-cloud-ec2-developer-role"
  cluster         = "${aws_ecs_cluster.test-ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.org-example-task-definition.family}:${max("${aws_ecs_task_definition.org-example-task-definition.revision}", "${data.aws_ecs_task_definition.ids-sevice-task.revision}")}"
  desired_count   = 1
 
  load_balancer {
    target_group_arn  = "${aws_lb_target_group.ecs-target-group.arn}"
    container_port    = 8080
    container_name    = "${var.container_definitions_name}-${var.environment}"
  }
}
