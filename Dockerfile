FROM python:3
MAINTAINER https://github.com/muccg/docker-awscli
ENV REFRESHED_AT 2016-03-03

RUN pip install awscli

ENV AMAZON_REGION=${AMAZON_REGION} AMAZON_ACCESS_KEY_ID=${AMAZON_ACCESS_KEY_ID} AMAZON_SECRET_ACCESS_KEY=${AMAZON_SECRET_ACCESS_KEY} 

COPY ./tools/ /tools/
VOLUME /root/

CMD ["aws"]
