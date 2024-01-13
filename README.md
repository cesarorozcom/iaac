# Learning AWS Cloudformation

This is a series of infrastructure as a code (IaaC)
examples in AWS to get deep knowledge.

## Setup

1. Create AWS IAM user with __AdministratorAccess__ policy attached.
2. Create AWS IAM role with the following policies:
   1. AdministratorAccess
   2. AmazonEC2FullAccess
   3. IAMFullAccess
3. Configure AccessKey / SecretKey for AWS Cloudformation user.

> Note: AWS Cloudformation role may increase in the attached policies to fulfill further requirements.

## AWS Cloudformation basics

Cloudformation is a service that enables to describe and represent infrastructure resources in the cloud with just a few lines of code.
The service allows you to use programming languages or text files to build models and provide all the necessary resources for the application to run in any region or under any account, automatically and securely.
The AWS Cloudformation service is free, and you only pay for the AWS resources needed for your application[^1].

### Key Concepts

* Template: Is a JSON or YAML formatted text file.
* Stacks: Is a single unit to manage related resources. The resources are mapped to the stack.
  The stack instantiates all specified resources in AWS. The can created, updated, and deleted.

> Note: Templates based on YAML use fewer punctuation marks, making them much easier to write and read. They also support comments, which is why I chose to use them here.

## Single EC2 Instance Stack

[Documentation](singleec2instance/index.md)

[^1]: [AWS Study Group](https://000037.awsstudygroup.com/1-introduce/)
