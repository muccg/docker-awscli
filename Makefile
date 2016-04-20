.PHONY: all

all: aws s3cmd

aws:
	docker build -t muccg/aws -f Dockerfile.aws .

s3cmd:
	docker build -t muccg/s3cmd -f Dockerfile.s3cmd .

testrun:
	docker run -it --rm -v ${PWD}:/data muccg/docker-aws

push:
	docker push muccg/aws
	docker push muccg/s3cmd
