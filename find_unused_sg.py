
import boto3, sys
# You should use the credential profile file 
ec2 = boto3.client("ec2", region_name=sys.argv[1])


# In boto3, if you have more than 1000 entries, you need to handle the pagination
# using the NextToken parameter, which is not shown here.

all_instances = ec2.describe_instances() 
all_sg = ec2.describe_security_groups()

instance_sg_set = set()
sg_set = set()

for reservation in all_instances["Reservations"]:
      for instance in reservation["Instances"]: 
              for sg in instance["SecurityGroups"]:
                        #instance_sg_set.add(sg["GroupName"]) 
                        instance_sg_set.add(sg["GroupId"]) 


for security_group in all_sg["SecurityGroups"]:
    #sg_set.add(security_group ["GroupName"])
    sg_set.add(security_group ["GroupId"])
    
idle_sg = sg_set - instance_sg_set
print(idle_sg)

# #debug
# print(type(idle_sg))

## TODO:
## + Create output in csv. 
