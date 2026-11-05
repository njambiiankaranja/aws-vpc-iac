variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to deploy into"
}

variable "availability_zone" {
  type        = string
  default     = "us-east-1a"
  description = "Availability zone for the subnets (must be in aws_region)"
}

variable "name_prefix" {
  type        = string
  default     = "cloud-vpc"
  description = "Prefix used in resource names and tags"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  type        = string
  default     = "10.0.3.0/24"
  description = "CIDR block for the private subnet"
}

variable "my_ip" {
  type        = string
  description = "Your public IP in CIDR form (for example 203.0.113.25/32), allowed to SSH in"

  validation {
    condition     = can(cidrhost(var.my_ip, 0))
    error_message = "my_ip must be a valid CIDR block, for example 203.0.113.25/32."
  }

  validation {
    condition     = var.my_ip != "0.0.0.0/0"
    error_message = "my_ip must not be 0.0.0.0/0, because that would open SSH to the whole internet."
  }
}