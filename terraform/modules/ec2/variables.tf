variable "ami_id" {
  description = "AMI ID for EC2 instances"
  default     = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "public_subnet_id" {
  description = "Public subnet ID for app server"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for DB server"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "app_sg_id" {
  description = "Security group ID for app server"
  type        = string
}

variable "db_sg_id" {
  description = "Security group ID for DB server"
  type        = string
}

variable "env_name" {
  description = "Environment name"
  type        = string
}
