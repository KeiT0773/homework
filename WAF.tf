# WAF
resource "aws_wafv2_web_acl" "aws-study-web-acl" {
  name        = "aws-study-web-acl"
  description = "First managed rule by access control list by aws"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
    sampled_requests_enabled   = true
  }

  tags = {
    Name = "aws-study-WAF-${var.my_env}"
  }

}
# Association between WAF and resource
resource "aws_wafv2_web_acl_association" "aws-study-web-acl-association" {
  resource_arn = aws_lb.aws-study-lb.arn
  web_acl_arn  = aws_wafv2_web_acl.aws-study-web-acl.arn
}