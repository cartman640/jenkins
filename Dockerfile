FROM jenkins:alpine
MAINTAINER Allan Ramsay

USER root
RUN apk add --update build-base python-dev python py-pip libffi-dev openssl-dev openssh docker && \
    pip install ansible && \
    apk del build-base python-dev py-pip libffi-dev openssl-dev && rm -rf /var/cache/apk/*

ADD ["drunner", "/drunner"]

RUN adduser jenkins docker && adduser jenkins ping

# lock in druser.
USER jenkins
