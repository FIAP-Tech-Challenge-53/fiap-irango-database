resource "aws_security_group" "cache" {
  name        = "${data.terraform_remote_state.infra.outputs.resource_prefix}-security-group-cache"
  description = "inbound: TCP/6379"
  vpc_id      = data.terraform_remote_state.infra.outputs.aws_vpc_id

  ingress {
    description = "Enable communication to the Amazon ElastiCache cluster. "
    from_port   = 6379
    to_port     = 6379
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${data.terraform_remote_state.infra.outputs.resource_prefix}-security-group-cache"
  }
}

resource "aws_elasticache_subnet_group" "default" {
  name = "${data.terraform_remote_state.infra.outputs.resource_prefix}-subnet-group-cache"
  subnet_ids = [
    data.terraform_remote_state.infra.outputs.subnet_private_a_id,
    data.terraform_remote_state.infra.outputs.subnet_private_b_id
  ]

  tags = {
    Name = "${data.terraform_remote_state.infra.outputs.resource_prefix}-subnet-group-cache"
  }
}

resource "aws_elasticache_cluster" "default" {
  cluster_id        = "${data.terraform_remote_state.infra.outputs.resource_prefix}-cache"
  engine            = "redis"
  node_type         = "cache.t3.micro"
  num_cache_nodes   = 1
  port              = 6379
  apply_immediately = true

  subnet_group_name  = aws_elasticache_subnet_group.default.name
  security_group_ids = [aws_security_group.cache.id]
  availability_zone  = data.terraform_remote_state.infra.outputs.default_az
}

output "aws_elasticache_cluster_endpoint" {
  value = aws_elasticache_cluster.default.cache_nodes[0].address
}
