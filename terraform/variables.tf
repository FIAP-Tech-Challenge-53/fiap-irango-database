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

variable "mongo_atlas_project_name" {
  type    = string
  default = "FIAP iRango"
}

variable "mongo_db_name" {
  default = "irango_cook"
}

variable "mongo_cluster_instance_size_name" {
  type    = string
  default = "M0"
}

variable "mongo_atlas_region" {
  type    = string
  default = "US_EAST_1"
}

variable "mongo_version" {
  type    = string
  default = "7.0"
}

# Secrets
variable "DB_USERNAME" {
  type = string
}

variable "DB_PASSWORD" {
  type = string
}

variable "MONGO_USERNAME" {
  type = string
}

variable "MONGO_PASSWORD" {
  type = string
}

variable "MONGO_ATLAS_ORG_ID" {
  type = string
}

# Outputs for variables
output "db_name" {
  value = var.db_name
}
