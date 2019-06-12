variable "aws_region" {
  description = "The region where AWS operations will take place"
  type        = "string"
  default     = "eu-west-1"
}

variable "environment" {
  description = "The name of the deployment environment."
  type        = "string"
  default     = "dev"
}

//variable "alias_name" {
//  description = "The name of the key alias"
//  type        = "string"
//  default     = "kea/encr/decr"
//}

