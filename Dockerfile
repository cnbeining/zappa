FROM lambci/lambda:build-python3.6

MAINTAINER "cnbeining" <i@cnbeining.com>

COPY yum.conf /etc/yum.conf

RUN yum clean all && \
    yum -y install gcc libyaml-devel

RUN pip3 install -U pip && \
    pip3 install -U zappa 

WORKDIR /var/task

RUN virtualenv -p python3 /var/venv && \
    source /var/venv/bin/activate && \
    pip install -U pip && \
    deactivate

COPY bashrc /root/.bashrc

CMD ["zappa"]
