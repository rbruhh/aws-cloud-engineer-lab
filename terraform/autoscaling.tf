# -------------------------
# Auto Scaling Group
# -------------------------
resource "aws_autoscaling_group" "app_asg" {
  name                = "cloudlab-app-asg"
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  health_check_type         = "ELB"
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app_tg.arn]

  tag {
    key                 = "Name"
    value               = "cloudlab-asg-instance"
    propagate_at_launch = true
  }
}
# -------------------------
# Auto Scaling Policy (Target Tracking CPU)
# -------------------------
resource "aws_autoscaling_policy" "cpu_target" {
  name                   = "cloudlab-cpu-target"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}