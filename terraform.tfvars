region = "us-east-1"
ecs_cluster = "org-example-cluster"
ecs_lb_name = "org-example-load-balancer"
aws_lb_target_group_name = "org-example-target-group"
aws_launch_configuration_name = "org-example-launch-configuration"
aws_autoscaling_group_name = "org-example-autoscaling-group"
aws_ecs_task_definition_name = "org-example-task-definition"
aws_ecs_service_name = "org-example-service-name"
container_definitions_name = "org-example-container"
ecs_repository = "08789734324.dkr.ecr.us-east-1.amazonaws.com/org.example/nodejs:8.x"
environment = "ci"
 
########################### Not used at the moment ################################
ecs_key_pair_name="$ECS_KEY_PAIR_NAME"
aws_access_key_id = "$PECT_AWS_KEYS_INTEGRATION_ACCESSKEY"
aws_secret_access_key = "$PECT_AWS_KEYS_INTEGRATION_SECRETKEY"
test_vpc = "$TEST_VPC"
test_network_cidr = "$TEST_NETWORK_CIDR"
test_public_01_cidr = "$TEST_PUBLIC_01_CIDR"
test_public_02_cidr = "$TEST_PUBLIC_02_CIDR"
max_instance_size = "5"
min_instance_size = "1"
desired_capacity = "1"