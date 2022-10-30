resource "aws_cloudwatch_metric_alarm" "shutdown_idle" {
  alarm_name          = "shutdown idle ec2 : ${var.minikube_instance_name}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "3600" # 1 hour
  statistic           = "Average"
  threshold           = "10"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = ["arn:aws:automate:${var.region}:ec2:stop"]
  dimensions = {
    InstanceId = "${aws_instance.minikube_instance.id}"
  }
}
