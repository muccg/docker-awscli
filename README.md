awscli
======

Dockerfile for awscli

Invoke using compose:

```
docker-compose run awscli --version
aws-cli/1.10.63 Python/3.5.2 Linux/4.4.0-36-generic botocore/1.4.5
```

```
docker-compose run awscli ec2 describe-instances --filters "Name=instance-state-name,Values=running"
```

Invoke using docker run:

```
docker run --rm \
           --interactive \
           --tty \
           --net "host" \
           -v "${HOME}/.aws:/data/.aws" \
           -it muccg/awscli --help
```

There is a convenience script in ./bin
