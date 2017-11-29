# Here's how we create the virtual machines

```
docker pull kizbitz/train
```

# starting
```
mkdir demo
./usergen.sh 70 > demo/users.cfg
docker run -ti --rm --env-file='train.env' -v $(pwd):/host kizbitz/train
```

# creating
```
train -vk
train -x docker
```

# deleting
```
train -d docker-1
#train -p Should use -t because -t does not work if no instances...
train -t
```

# login
```
ssh -i user0-demo.pem ubuntu@54.183.75.104
```
