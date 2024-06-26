# Invidious HA on AWS
This repository contains templates to deploy highly available Invidious instance on AWS. This architecture makes use of RDS MultiAZ, Application LoadBalancer and Auto Scaling Groups.

## Infrastracture
- Two subnets in different availability zones
- RDS in higly available mode and snapshots enabled
- Auto Scaling Group (instances: 2 min, 4 max)
- Launch Template with t3.micro instance type and bootstrap configuration script
- Application Load Balancer