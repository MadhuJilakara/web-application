resource "aws_cloudwatch_metric_alarm" "ec2-metric-alarm" {
  alarm_name          = "ec2-metric-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_actions       = [aws_sns_topic.cpu-util-topic.arn]

  dimensions = {
    InstanceId = aws_instance.TfTest.id
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
}

