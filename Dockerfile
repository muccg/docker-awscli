FROM python:3.6-alpine
MAINTAINER https://github.com/muccg

ARG ARG_AWSCLI_VERSION

ENV VIRTUAL_ENV /env
ENV PIP_NO_CACHE_DIR="off"
ENV PYTHON_PIP_VERSION 9.0.1
ENV PYTHONIOENCODING=UTF-8
ENV AWSCLI_VERSION $ARG_AWSCLI_VERSION

RUN apk --no-cache add \
    ca-certificates \
    groff \
    less

RUN pyvenv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install --upgrade \
    pip==$PYTHON_PIP_VERSION \
    awscli==$ARG_AWSCLI_VERSION

ENV PATH $VIRTUAL_ENV/bin:$PATH

RUN addgroup -g 1000 aws \
  && adduser -D -h /data -H -S -u 1000 -G aws aws \
  && mkdir /data \
  && chown aws:aws /data

USER aws

ENTRYPOINT ["/env/bin/aws"]
