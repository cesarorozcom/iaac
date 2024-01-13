#!/usr/bin/env bash
set -e

aws cloudformation create-stack \
--stack-name asg-cloudformation-stack \
--template-body file://${PWD}/singleec2instance/singleec2instance.yml \
--parameters ParameterKey=SubnetID,ParameterValue=subnet-0a5bef0a0408f13b9 ParameterKey=VPCID,ParameterValue=vpc-0b75f339082ea842e \
--capabilities CAPABILITY_IAM --region us-east-1
