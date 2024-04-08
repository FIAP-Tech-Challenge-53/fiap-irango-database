resource "aws_security_group" "rds" {
  name        = "${data.terraform_remote_state.infra.outputs.resource_prefix}-security-group-rds"
  description = "inbound: TCP/3306 + outbound: none"
  vpc_id      = data.terraform_remote_state.infra.outputs.aws_vpc_id

  ingress {
    description = "MYSQL/Aurora"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
  }

  tags = {
    Name = "${data.terraform_remote_state.infra.outputs.resource_prefix}-security-group-rds"
  }
}

resource "aws_db_subnet_group" "default" {
  name = "${data.terraform_remote_state.infra.outputs.resource_prefix}-subnet-group-rds"
  subnet_ids = [
    data.terraform_remote_state.infra.outputs.subnet_private_a_id,
    data.terraform_remote_state.infra.outputs.subnet_private_b_id
  ]

  tags = {
    Name = "${data.terraform_remote_state.infra.outputs.resource_prefix}-subnet-group-rds"
  }
}

resource "aws_db_instance" "default" {
  instance_class       = var.db_instance_class
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  parameter_group_name = var.db_parameter_group_name

  identifier = "${data.terraform_remote_state.infra.outputs.resource_prefix}-rds"

  storage_type          = "gp2"
  allocated_storage     = 20
  max_allocated_storage = 0

  skip_final_snapshot = true
  publicly_accessible = false
  multi_az            = false
  db_name             = var.db_name
  username            = var.db_user
  password            = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  availability_zone      = data.terraform_remote_state.infra.outputs.default_az

  tags = {
    Name = "${data.terraform_remote_state.infra.outputs.resource_prefix}-rds"
  }
}

output "aws_db_instance_endpoint" {
  value = aws_db_instance.default.endpoint
}
