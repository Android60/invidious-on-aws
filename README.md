# Invidious HA on AWS
This repository contains templates to deploy highly available Invidious instance on AWS. This architecture makes use of RDS MultiAZ, Application LoadBalancer and Auto Scaling Groups.

## infrastructure
- Two subnets in different availability zones
- RDS in higly available mode and snapshots enabled
- Auto Scaling Group (instances: 2 min, 4 max)
- Scaling Policy that will maintain 50% CPU utilization across ASG
- Launch Template with t3.micro instance type and bootstrap configuration script
- Application Load Balancer
![infrastructure  diagram](/images/infrastructure.png "Infrastructure diagram")


# Create Invidious AMI
You need to build AMI for Invidious with included Packer template.
```
packer build packer/invidious.pkr.hcl
```

# Deploy with Cloudformation
```
# Set AMI ID from previous step
export AMI='ami-1234yourami678'
aws cloudformation deploy --stack-name invidious --template-file cloudformation.yaml --parameter-overrides AMI=$AMI --capabilities CAPABILITY_IAM
```
