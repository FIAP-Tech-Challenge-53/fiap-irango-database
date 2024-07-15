resource "mongodbatlas_project" "default" {
  org_id = var.MONGO_ATLAS_ORG_ID
  name   = var.mongo_atlas_project_name
}


resource "mongodbatlas_database_user" "default" {
  username           = var.MONGO_USERNAME
  password           = var.MONGO_PASSWORD
  project_id         = mongodbatlas_project.default.id
  auth_database_name = "admin"
  roles {
    role_name     = "readWrite"
    database_name = var.mongo_db_name
  }
}

resource "mongodbatlas_project_ip_access_list" "default" {
  project_id = mongodbatlas_project.default.id
  cidr_block = "0.0.0.0/0"
  comment    = "cidr block for tf acc testing"
}

resource "mongodbatlas_cluster" "default" {
  project_id                  = mongodbatlas_project.default.id
  name                        = "${data.terraform_remote_state.infra.outputs.resource_prefix}-cluster"
  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = var.mongo_atlas_region
  provider_instance_size_name = var.mongo_cluster_instance_size_name
  mongo_db_major_version      = var.mongo_version
}

output "mongo_endpoint" {
  value = mongodbatlas_cluster.default.connection_strings[0].standard_srv
}
