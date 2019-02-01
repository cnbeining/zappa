FROM lambci/lambda:build-python3.6

MAINTAINER "cnbeining" <i@cnbeining.com>

COPY yum.conf /etc/yum.conf

RUN yum clean all && \
    yum -y install vim postgresql postgresql-devel mysql mysql-devel gcc lapack-devel blas-devel libyaml-devel && \
    yum --enablerepo=epel -y install hdf5-devel && \
    pip install -U pip && \
    pip install -U zappa mysql-python

WORKDIR /var/task

RUN virtualenv -p python3 /var/venv && \
    source /var/venv/bin/activate && \
    pip install -U pip && \
    deactivate

COPY bashrc /root/.bashrc

CMD ["zappa"]
