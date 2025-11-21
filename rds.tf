# Read RDS password
data "aws_secretsmanager_secret" "rds_secret" {
  name = "rds-password"
}
data "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = data.aws_secretsmanager_secret.rds_secret.id
}

# RDS instance
resource "aws_db_instance" "aws-study-rds" {
  identifier                  = "aws-study-database-${var.my_env}"
  engine                      = "mysql"
  engine_version              = "8.0.42"
  instance_class              = "db.t3.micro"
  allocated_storage           = 20
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true
  skip_final_snapshot         = true
  # authentication
  username = "root"
  password = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)["password"]
  # RDS parameter
  parameter_group_name = aws_db_parameter_group.aws-study-rds-params.name
  # network
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.aws-study-rds-subnet.name
  tags = {
    Name = "aws-study-rds-${var.my_env}"
  }
}

output "aws_study-db_instance" {
  value = aws_db_instance.aws-study-rds.id
}

# RDS-subnet-group
resource "aws_db_subnet_group" "aws-study-rds-subnet" {
  name       = "aws-study-rds-subnet-group"
  subnet_ids = [aws_subnet.PrivateAZ1a.id, aws_subnet.PrivateAZ1c.id]
  tags = {
    Name = "aws-study-rds-subnet-group-${var.my_env}"
  }
}

output "aws_study-db_subnet" {
  value = aws_db_subnet_group.aws-study-rds-subnet.id
}

# RDS-parameter
resource "aws_db_parameter_group" "aws-study-rds-params" {
  name        = "aws-study-rds-params"
  family      = "mysql8.0"
  description = "Custom parameter group for aws-study RDS"
  # Defalt character set for MySQL server
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
  # Dfinition of compare or sort method for string
  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }
  # Log for query which takes long excution time
  parameter {
    name  = "slow_query_log"
    value = "1" # enable
  }
  # Specify log-output
  parameter {
    name  = "log_output"
    value = "TABLE" # Internal table in MySQL  
  }
  tags = {
    Name = "aws-study-rds-params-${var.my_env}"
  }
}
