variable "env" {
    description = "this is env for my infra"
    type = string
}

variable "instance_type" {
    description = "instance for infra tf"
    type = string
}

variable "ec2_ami_id" {
    description = "this is instance ami_id"
    type = string
}

variable "instance_count" {
  description = "this is no of instance "
  type = number
}

variable "bucket_name" {
  description = "this is bucket for infra"
  type = string
}

variable "hash_key" {
  description= "this is hash key of my ec2 instance"
  type = string
  
}