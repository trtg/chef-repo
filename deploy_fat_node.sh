#!/bin/bash
#sample script to create nodes of a given role, we could extend this to take a role name or just have one script per role

#TODO: decide on a bigger instance type to use for this node
AMI_ID="ami-137bcf7a"
INSTANCE_TYPE="t1.micro"
SECURITY_GROUPS="fat_node" 
RUNLIST="role[fat_node]"

knife ec2 server create -x ubuntu -I $AMI_ID  -f $INSTANCE_TYPE -G $SECURITY_GROUPS -r $RUNLIST
