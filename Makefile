.PHONY: all

all: aws s3cmd

aws:
	docker build -t muccg/docker-aws -f Dockerfile.aws .

s3cmd:
	docker build -t muccg/docker-s3cmd -f Dockerfile.s3cmd .

testrun:
	docker run -it --rm -v ${PWD}:/data muccg/docker-aws

push:
	docker push muccg/docker-aws
	docker push muccg/docker-s3cmd
