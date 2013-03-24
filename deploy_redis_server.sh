#!/bin/bash
#sample script to create nodes of a given role, we could extend this to take a role name or just have one script per role

AMI_ID="ami-137bcf7a"
INSTANCE_TYPE="t1.micro"
SECURITY_GROUPS="redis_server"
RUNLIST="role[qless_server]"

knife ec2 server create -x ubuntu -I $AMI_ID  -f $INSTANCE_TYPE -G $SECURITY_GROUPS -r $RUNLIST
