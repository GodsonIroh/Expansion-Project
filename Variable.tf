variable "region" {
  description = "AWS provider"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "Pub_Sub1_cidr" {
  description = "Public Subnet 1 cidr"
  type        = string
  default     = "10.0.1.0/24"
}

variable "Pub_Sub2_cidr" {
  description = "Public Subnet 2 cidr"
  type        = string
  default     = "10.0.2.0/24"
}

variable "Priv_Sub1_cidr" {
  description = "Private Subnet 1 cidr"
  type        = string
  default     = "10.0.3.0/24"
}

variable "Priv_Sub2_cidr" {
  description = "Private Subnet 2 cidr"
  type        = string
  default     = "10.0.4.0/24"
}

variable "ami" {
  description = "t2 micro ami"
  type        = string
  default     = "ami-09d6bbc1af02c2ca1"
}

variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_subnet_id" {
  description = "subnet hosting ec2 instance"
  type        = string
  default     = "aws_subnet.Expansion-Pub-Sub1.id"
}

variable "key_name" {
  description = "key pair name"
  type        = string
  default     = "Expansion-KP"
}

variable "filename" {
  description = "key pair filename on local computer"
  type        = string
  default     = "Expansion-KP"
}

variable "security_group_name" {
  description = "security group name"
  type        = string
  default     = "Security group using terraform"
}
