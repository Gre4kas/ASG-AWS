# Define variables for providers.tf
variable "aws_region" {
  default     = "us-east-1"
  description = "aws region"
}

variable "prefix" {
  description = "Prefix for tag"
  type        = string
  default     = "test"
}

variable "public_key_path" {
  description = "The path to the public key file"
  default     = "~/.ssh/aws_instance.pub"
}

variable "ami" {
  description = "The ID of the AMI to use for the instance"
  default     = "ami-04a81a99f5ec58529"
}

variable "instance_type" {
  description = "The type of the EC2 instance"
  default     = "t2.micro"
}

variable "user_data_file" {
  description = "The path to the user data script"
  default     = "script.sh"
}

# Networks 

variable "cidr_block" {
  description = "CIDR block for the network, default is 0.0.0.0/0 (allows all inbound traffic)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. This defines the IP address range for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of Availability Zones to be used for the VPC."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  description = "A list of CIDR blocks for public subnets within the VPC."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "A list of CIDR blocks for private subnets within the VPC."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "database_subnets" {
  description = "A list of CIDR blocks for database subnets within the VPC."
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}