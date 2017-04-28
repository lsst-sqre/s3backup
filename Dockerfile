FROM docker.io/centos:7
MAINTAINER sqre-admin

USER root
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y python-pip
# the system package for pip will be old
RUN pip install --upgrade pip
RUN pip install awscli
RUN yum clean all -y

RUN useradd s3backup
COPY scripts/s3backup /usr/local/bin/s3backup

USER s3backup
CMD  ["/usr/local/bin/s3backup"]
