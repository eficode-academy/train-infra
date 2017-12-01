# Here's how we create the virtual machines

```sh
docker pull kizbitz/train
```

Read more here:
 [kizbitz/train](https://github.com/kizbitz/train)

# Configure train.env file

Fill out at least:

```
# Trainer (username) is only used for tagging VCP objects only. It is not tied to any permissions.
TRAINER=


# Tag for VPC, labs, instances, etc... (Recommended for different environments)
# This name must match the folder name where you create your users.
VPC=demo

# The region where you want your machines. eu-central-1 (Frankfurt) is usually a good place.
AWS_REGION=eu-central-1

# Your AWS account credentials
AWS_ACCESS_KEY_ID=<id>
AWS_SECRET_ACCESS_KEY=<key>
```

If you do not want to put your keys in the train.env file, they can be passed into the docker train container as env. variables when running the container, or by exporting them directly in the container after launch.

# Starting
Clone this repo. Then run the following. The 70 in the example is the number of students that need environments.

```sh
mkdir demo
./usergen.sh 70 > demo/users.cfg
```

This will create a users.cfg file with an entry for each user.

Then we can use the train tool to create AWS machines for the users:

```sh
docker run -ti --rm --env-file='train.env' -v $(pwd):/host kizbitz/train
```

# Creating

```sh
train -vk
train -x docker
```

The train tool will prompt how many instances you need. Note: this is the number of instances *per user*, so often 1, unless you need for instance 2 or 3 per student for multi host Docker stuff or for running Jenkins master and slave on separate machines.

# Deleting

```sh
train -d docker-1
```

train -p Should use -t because -t does not work if no instances...

```sh
train -t
```

# Login
The train tool creates a folder for each user. The folder contains a docker-1.txt file with content similar to:

```
AWS Instances:

Name:         user0-demo
  IP:         18.194.227.253
  Private IP: 10.0.6.50
  Public DNS: ec2-18-194-227-253.eu-central-1.compute.amazonaws.com
```

If you asked for more than one instance per user, then the file will contain several instances.

The folder also contains userXXX.pem and userXXX.ppk key files for authentication.

Using command line ssh, you can run one of the following:

```sh
ssh -i user0-demo.pem ubuntu@[IP]
ssh -i user0-demo.pem ubuntu@[Public DNS]
```

On windows using Putty, use the .ppk file instead. TODO: Describe how.

## Security
By default, machines are created with a firewall rule that only allows traffic from the IP you were on when running the train script. This might very well not be what you need.

If you observe connection timeout issues, this is probably the reason.

Solution:
* Go to the AWS console. Find your instances under EC2 instances.
* Under each instance, in the tabs at the bottom, is a link to the security group used. Go to the security group to change the firewall rules.
* Edit inbound rules - > Add rule -> All traffic, from Anywhere. This affects the security group, so it applies for all the machines you created.
* 
