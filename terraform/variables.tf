# RDS
variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_engine" {
  default = "mysql"
}

variable "db_engine_version" {
  default = "5.7"
}

variable "db_parameter_group_name" {
  default = "default.mysql5.7"
}

variable "db_name" {
  default = "irango"
}

variable "db_name_payment" {
  default = "irango_payment"
}

variable "cache_engine" {
  default = "redis"
}

variable "cache_node_type" {
  default = "cache.t3.micro"
}

# Secrets
variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}

# Outputs for variables
output "db_name" {
  value = var.db_name
}