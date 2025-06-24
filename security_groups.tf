resource "aws_security_group" "rds" {
  name        = "rds-sg"
  description = "Allow MySQL access from EKS SG"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_security_group_rule" "allow_mysql_from_eks" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = module.eks.node_security_group_id

  description = "Allow inbound MySQL access from EKS"
}