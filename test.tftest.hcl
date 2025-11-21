# Valiables
variables {
  my_env = "test"
}

# test
run "check_VPC" {

  command = apply

  assert {
    condition     = aws_vpc.main_vpc.cidr_block == "10.2.0.0/16"
    error_message = "VPC cidrblock did not match expected"
  }

  assert {
    condition     = aws_subnet.PublicAZ1a.availability_zone == "ap-northeast-1a"
    error_message = "AZ for PublicAZ1a did not match expected"
  }

  assert {
    condition     = aws_subnet.PublicAZ1c.availability_zone == "ap-northeast-1c"
    error_message = "AZ for PublicAZ1c did not match expected"
  }

  assert {
    condition     = aws_subnet.PrivateAZ1a.availability_zone == "ap-northeast-1a"
    error_message = "AZ for PrivateAZ1a did not match expected"
  }

  assert {
    condition     = aws_subnet.PrivateAZ1c.availability_zone == "ap-northeast-1c"
    error_message = "AZ for PrivateAZ1c did not match expected"
  }

}

run "check_EC2_1" {

  command = apply

  assert {
    condition     = aws_instance.ec2_1.ami == "ami-01205c30badb279ec"
    error_message = "EC2 ami did not match expected"
  }

  assert {
    condition     = aws_instance.ec2_1.instance_type == "t3.micro"
    error_message = "EC2 instance type did not match expected"
  }

}

run "check_EC2_2" {

  command = apply

  assert {
    condition     = aws_instance.ec2_2.ami == "ami-01205c30badb279ec"
    error_message = "EC2 ami did not match expected"
  }

  assert {
    condition     = aws_instance.ec2_2.instance_type == "t3.micro"
    error_message = "EC2 instance type did not match expected"
  }

}

run "check_EC2_SG_SSH" {
  command = apply

  assert {
    condition = anytrue([
      for r in aws_security_group.ec2.ingress :
      contains(try(r.cidr_blocks, []), "207.65.168.137/32")
    ])
    error_message = "SSH ingress did not allow expected CIDR"
  }
}


run "check_RDS" {

  command = apply

  assert {
    condition     = aws_db_instance.aws-study-rds.engine == "mysql"
    error_message = "RDS engine did not match expected"
  }

  assert {
    condition     = aws_db_instance.aws-study-rds.instance_class == "db.t3.micro"
    error_message = "RDS instance class did not match expected"
  }

}

run "check_ELB" {

  command = apply

  assert {
    condition     = aws_lb_target_group.aws-study-lb-tg.port == 8080
    error_message = "ELB target group port did not match expected"
  }

  assert {
    condition     = aws_lb_target_group_attachment.ec2_1.port == 8080
    error_message = "ELB target group attachment port did not match expected"
  }

  assert {
    condition     = aws_lb_target_group_attachment.ec2_2.port == 8080
    error_message = "ELB target group attachment port did not match expected"
  }  

}

run "check_WAF_rule" {
  command = apply

  assert {
    condition = anytrue([
      for r in aws_wafv2_web_acl.aws-study-web-acl.rule :
      anytrue([
        for s in r.statement :
        anytrue([
          for t in s.managed_rule_group_statement :
          try(t.name, "") == "AWSManagedRulesCommonRuleSet"
        ])
      ])
    ])
    error_message = "WAF managed_rule_group_statement name did not match expected"
  }
}

run "check_CloudWatch_metrics" {

  command = apply

  assert {
    condition     = aws_cloudwatch_metric_alarm.aws-study-cloudwatch.metric_name == "CPUUtilization"
    error_message = "CloudWatch metrics did not match expected"
  }

  assert {
    condition     = aws_cloudwatch_metric_alarm.aws-study-cloudwatch.comparison_operator == "GreaterThanOrEqualToThreshold"
    error_message = "CloudWatch metrics comparison_operator did not match expected"
  }

  assert {
    condition     = aws_cloudwatch_metric_alarm.aws-study-cloudwatch.threshold == 70
    error_message = "CloudWatch metrics threshold did not match expected"
  }
}
