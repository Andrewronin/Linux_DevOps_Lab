#! /bin/bash

aws configure

# AWS Access Key ID [None]: #PASSWORD#
# AWS Secret Access Key [None]: #PASSWORD#
# Default region name [None]: us-east-1
# Default output format [None]: json

#Create User and Group

aws iam create-group --group-name Checker
aws iam attach-group-policy --group-name Checker --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess
aws iam create-user --user-name igor_veretennikov@epam.com
aws iam add-user-to-group --user-name igor_veretennikov@epam.com --group-name Checker
aws iam create-access-key --user-name igor_veretennikov@epam.com

# Create EC2

aws ec2 create-image --instance-id i-0f5a0ca202e26dda9 --name "Veretennikov_img"

aws ec2 describe-subnets --filters "Name=availabilityZone,Values=us-east-1b"

aws ec2 run-instances --image-id ami-960611ed --instance-type t2.micro --key-name veretennikov --subnet-id subnet-0cea3c68

aws ec2 modify-instance-attribute --groups sg-cbc4eabb --instance-id i-0054d78447c173b74

aws ec2 create-tags --resources i-0054d78447c173b74 --tags Key=name,Value=az-b

# Auto Scaling

aws autoscaling create-launch-configuration \
	--launch-configuration-name LC-Veretennikov \
	--image-id ami-960611ed  \
	--security-groups “Web” \
	--instance-type t2.micro

aws autoscaling create-auto-scaling-group \
	--auto-scaling-group-name ASG-Veretennikov \
	--launch-configuration-name LC-Veretennikov \
	--availability-zones "us-east-1a" "us-east-1b" \
	--load-balancer-names "LB-Veretennikov" \
	--max-size 2 --min-size 1 --desired-capacity 2

aws autoscaling put-scaling-policy \
	--policy-name ASPolicy-UP-Veretennikov \
	--auto-scaling-group-name ASG-Veretennikov \
	--scaling-adjustment 1 \
	--adjustment-type ChangeInCapacity

aws cloudwatch put-metric-alarm \
	--alarm-name RequestCount-UP-Veretennikov \
	--metric-name RequestCount \
	--namespace AWS/ELB --statistic Sum --period 60 --threshold 10 \
	--comparison-operator GreaterThanOrEqualToThreshold \
	--dimensions "Name= LoadBalancerName,Value= LB-Veretennikov " \
	--evaluation-periods 2 \
	--alarm-actions PolicyARN

aws autoscaling put-scaling-policy \
	--policy-name ASPolicy-DOWN-Veretennikov \
	--auto-scaling-group-name ASG-Veretennikov \
	--scaling-adjustment -1 \
	--adjustment-type ChangeInCapacity


aws cloudwatch put-metric-alarm \
	--alarm-name RequestCount-DOWN-Veretennikov \
	--metric-name RequestCount \
	--namespace AWS/ELB --statistic Sum --period 60 --threshold 10 \
	--comparison-operator LessThanThreshold \
	--dimensions "Name= LoadBalancerName,Value= LB-Veretennikov " \
	--evaluation-periods 2 \
	--alarm-actions PolicyARN

