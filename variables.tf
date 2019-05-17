variable "ecs_cluster" {
  description = "ECS cluster name"
}
 
variable "region" {
  description = "AWS region"
}
 
variable "ecs_lb_name" {
  description = "ECS LB name"
}
 
variable "aws_lb_target_group_name" {
  description = "AWS LB group name"
}
 
variable "aws_launch_configuration_name" {
  description = "AWS Launch configuration name"
}
 
variable "aws_autoscaling_group_name" {
  description = "AWS Autoscaling Group name"
}
 
variable "aws_ecs_task_definition_name" {
  description = "AWS Task name"
}
 
variable "aws_ecs_service_name" {
  description = "AWS Cluster Service name"
}
 
variable "container_definitions_name" {
  description = "AWS Cluster Service container name"
}
 
variable "environment" {
  description = "Instance environment"
}
 
 ########################### Variables not used at the moment ################################
# main creds for AWS connection
variable "aws_access_key_id" {
  description = "AWS access key"
}
 
variable "aws_secret_access_key" {
  description = "AWS secret access key"
}
 
variable "ecs_key_pair_name" {
  description = "EC2 instance key pair name"
}
 
variable "availability_zone" {
  description = "availability zone used for the demo, based on region"
  default = {
    us-east-1 = "us-east-1"
  }
}
 
########################### Test VPC Config ################################
 
variable "test_vpc" {
  description = "VPC name for Test environment"
}
 
variable "test_network_cidr" {
  description = "IP addressing for Test Network"
}
 
variable "test_public_01_cidr" {
  description = "Public 0.0 CIDR for externally accessible subnet"
}
 
variable "test_public_02_cidr" {
  description = "Public 0.0 CIDR for externally accessible subnet"
}
 
########################### Autoscale Config ################################
 
variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
}
 
variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
}
 
variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
}
 
########################### ECR Repository ################################
 
variable "ecs_repository" {
  description = "ECR name"
}