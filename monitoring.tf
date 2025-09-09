resource "aws_autoscaling_policy" "target_tracking_cpu" {
  name                   = "${var.name_prefix}-target-tracking-cpu"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.this.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value     = 70.0
    disable_scale_in = false
  }
}
