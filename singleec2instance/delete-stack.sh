#!/usr/bin/env bash

set -e

aws cloudformation delete-stack \
--stack-name asg-cloudformation-stack