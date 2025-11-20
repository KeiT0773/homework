# CloudWatch
resource "aws_cloudwatch_metric_alarm" "aws-study-cloudwatch" {
  alarm_name          = "aws-study-cpu-utilization-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  datapoints_to_alarm = 2
  treat_missing_data  = "missing"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This metric monitors ec2 cpu utilization"
  actions_enabled     = true
  alarm_actions = [
    "arn:aws:sns:ap-northeast-1:512795167785:Cloudwatch-alert-topic"
  ]
  tags = {
    Name = "aws-study-cloudwatch-${var.my_env}"
  }
}