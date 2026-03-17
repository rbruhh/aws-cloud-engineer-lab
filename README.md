\# AWS Cloud Engineer Lab



\## Overview

This project provisions a cost-conscious AWS web application environment using Terraform. It includes a VPC with public and private subnets, an internet-facing Application Load Balancer, an Auto Scaling Group for the application tier, VPC Flow Logs, ALB access logs, and Systems Manager access for private instance management.



\## Architecture

\- VPC across two Availability Zones

\- Public subnets for ALB and bastion

\- Private subnets for app instances

\- S3 Gateway VPC Endpoint for low-cost private access

\- Application Load Balancer

\- Launch Template + Auto Scaling Group

\- CloudWatch alarm for unhealthy ALB targets

\- ALB access logs delivered to S3

\- SSM-based management for private instances



\## Features

\- Private app tier behind public ALB

\- Cost-conscious design with no NAT Gateway

\- Target tracking auto scaling

\- VPC Flow Logs enabled

\- ALB access logging enabled

\- CloudWatch monitoring enabled



\## Validation

\- ALB returns HTTP 200

\- ASG instances register healthy in target group

\- Private instance is reachable through SSM

\- Terraform plan shows no drift



\## Cost-Conscious Design Decisions

\- No custom domain or ACM certificate

\- No NAT Gateway

\- S3 Gateway Endpoint used instead of broader outbound internet access

\- HTTP-only ALB used for lab purposes



\## Future Improvements

\- HTTPS with ACM and Route 53

\- WAF in front of the ALB

\- Remote Terraform backend with S3 and DynamoDB

\- RDS in private subnets

\- CI/CD pipeline deployment

