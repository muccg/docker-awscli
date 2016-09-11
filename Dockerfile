FROM python:3.5-slim
MAINTAINER https://github.com/muccg

ARG ARG_AWSCLI_VERSION
ARG ARG_PIP_OPTS="--upgrade --no-cache-dir"

ENV VIRTUAL_ENV /env
ENV PYTHON_PIP_VERSION 8.1.2
ENV PYTHONIOENCODING=UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
    less \
    man \
    openssh-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pyvenv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install $ARG_PIP_OPTS \
    pip==$PYTHON_PIP_VERSION \
    awscli==$ARG_AWSCLI_VERSION

ENV PATH $VIRTUAL_ENV/bin:$PATH

RUN addgroup --gid 1000 aws \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup aws aws \
  && mkdir /data \
  && chown aws:aws /data

USER aws

ENTRYPOINT ["/env/bin/aws"]
