FROM centos:latest

LABEL AUTHOR="khoapbt@rikkeisoft.com"

ENV DEBIAN_FRONTEND noninteractive
ENV http_proxy 'http://192.168.1.2:3128'
ENV https_proxy 'https://192.168.1.2:3128'

ENV container docker

# Config Group System
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
  systemd-tmpfiles-setup.service ] || rm -f $i; done); \
  rm -f /lib/systemd/system/multi-user.target.wants/*;\
  rm -f /etc/systemd/system/*.wants/*;\
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*;\
  rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

# Install PHP
RUN yum clean all && yum update -y && yum install -y epel-release
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php71
RUN yum install -y php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysql php-fpm \
    php-curl php-mbstring php-xml php-zip php-json
RUN mkdir -p /run/php-fpm

# Install Compose
RUN yum update
RUN curl --proxy http://192.168.1.2:3128 -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Install nginx
RUN yum install -y nginx supervisor redis git

# Install Node && NPM
RUN yum update
RUN curl --proxy http://192.168.1.2:3128 -sL https://rpm.nodesource.com/setup_8.x | bash -
RUN yum install -y nodejs

RUN yum clean all

RUN systemctl enable nginx
RUN systemctl enable php-fpm
RUN systemctl enable redis
RUN systemctl enable supervisord

EXPOSE 80

# Default command
CMD ["/usr/sbin/init"]