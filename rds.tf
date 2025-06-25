module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "demo-rds-mosaws"

  engine            = "mysql"
  engine_version    = "8.0.41"
  instance_class    = "db.m5d.large"
  allocated_storage = 5

  port     = "3306"
  db_name  = "demo_rds_db"
  password = local.db_credentials.rds_password
  username = local.db_credentials.rds_username

  manage_master_user_password = false

  iam_database_authentication_enabled = false

  subnet_ids             = module.vpc.private_subnets
  create_db_subnet_group = true
  vpc_security_group_ids = [aws_security_group.rds.id]

  deletion_protection       = false
  create_db_option_group    = false
  create_db_parameter_group = false

  tags = {
    Environment = "Test"
    Terraform   = "True"
  }
}

data "aws_secretsmanager_secret" "db_secret" {
  name = "rds-credentials"
}

data "aws_secretsmanager_secret_version" "db_creds" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}