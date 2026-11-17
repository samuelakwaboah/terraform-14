variable "vpc-cider_block" {
  description = "The vpc cidr block"
  type        = string
  default     = "10.10.0.0/16"
}

variable "region_name" {
    default = "us-east-1"
}