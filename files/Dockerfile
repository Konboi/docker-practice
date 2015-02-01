FROM centos:centos6
MAINTAINER Konboi

RUN echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock

# install yum-config-manager & sudo
RUN yum -y install yum-utils sudo ntp && yum -y clean all

# set timezone
RUN rm -f /etc/localtime
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# install epel
RUN yum -y localinstall http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum-config-manager --enable epel

# install MySQL
RUN yum -y localinstall http://downloads.mysql.com/archives/get/file/MySQL-shared-compat-5.5.36-1.el6.x86_64.rpm &&  yum -y localinstall http://downloads.mysql.com/archives/get/file/MySQL-devel-5.5.36-1.el6.x86_64.rpm && yum -y localinstall http://downloads.mysql.com/archives/get/file/MySQL-server-5.5.36-1.el6.x86_64.rpm && yum -y localinstall http://downloads.mysql.com/archives/get/file/MySQL-client-5.5.36-1.el6.x86_64.rpm && yum -y localinstall http://downloads.mysql.com/archives/get/file/MySQL-shared-5.5.36-1.el6.x86_64.rpm

# install various packages
RUN yum -y groupinstall "Development Tools"
RUN yum -y install nc telnet dstat git ngrep strace expat-devel tar libxml2-devel zlib

# ref) http://blog.urban-theory.net/2014/06/16/openssl-devel-install-fails-on-centos-with-docker
RUN yum -y install --enablerepo=centosplus openssl-devel

# create user
RUN useradd -u 1000 -k /etc/skel/ -m app -s /bin/bash
ADD profile /home/app/.profile
RUN mkdir -p /home/app/.ssh
ADD id_rsa.pub  /home/app/.ssh/sample_app_rsa.pub
ADD id_rsa      /home/app/.ssh/sample_app_rsa
ADD ssh_config  /home/app/.ssh/config

RUN chown app:app /home/app/.profile
RUN chown -R app:app /home/app/.ssh
RUN chmod 0600 /home/app/.ssh/id_rsa
RUN chmod 0600 /home/app/.ssh/config

USER app
ENV USER app
ENV HOME /home/app

# install xbuild
RUN git clone https://github.com/tagomoris/xbuild.git /home/app/local/xbuild

RUN mkdir -p /home/app/local/perl
RUN /home/app/local/xbuild/ruby-install 2.2.0 /home/app/local/ruby/ -- -j4

# clone repository & setup carton
# RUN git clone https://github.com/kayac/nikuapp.git /home/app/nikuapp
RUN git clone git@github.com:Konboi/docker-practice.git /home/app/sinatra-app
WORKDIR /home/app/sinatra-app
RUN /home/app/local/perl/bin/carton install

USER root
ENV USER root
RUN yum install -y cronie ntp
ADD ntp.conf  /etc/ntp.conf
RUN ntpq -p
RUN echo "app ALL=NOPASSWD: /usr/sbin/ntpdate" >> /etc/sudoers

#USER app
#ENV USER app
#CMD /bin/sh /home/app/nikuapp/docker_run.sh
