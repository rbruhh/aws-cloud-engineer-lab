output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "asg_name" {
  value = aws_autoscaling_group.app_asg.name
}

output "bastion_instance_id" {
  value = aws_instance.bastion.id
}

output "target_group_arn" {
  value = aws_lb_target_group.app_tg.arn
}

output "alb_log_bucket_name" {
  value = aws_s3_bucket.alb_logs.bucket
}