FROM centos:7

###compile nginx##
RUN  mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup && \
     curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
     curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && yum clean all && \
     yum install -y iproute lrzsz openssh-server gcc pcre-devel openssl-devel zlib-deve make && \
     sed -i 's|#UseDNS yes|UseDNS no|g' /etc/ssh/sshd_config && \
     ssh-keygen -A && echo 'root:123456'|chpasswd
ADD  nginx-1.18.0.tar.gz /
RUN  mv nginx-1.18.0  nginx && rm -f nginx-1.18.0.tar.gz
WORKDIR nginx
RUN  sed -i -e 's/1.18.0//g' -e 's/nginx\//Andy/g' -e 's/"NGINX"/"Andy"/g' src/core/nginx.h && \
     ./configure --prefix=/usr/local/nginx --with-http_ssl_module && \
     make && make install
ADD  nginx.conf /usr/local/nginx/conf/nginx.conf
ADD  index.php /usr/local/nginx/html/index.php

###complie php7###
RUN  yum install -y libxml2 libxml2-devel openssl openssl-devel bzip2 bzip2-devel libcurl libcurl-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel gmp gmp-devel libmcrypt libmcrypt-devel readline readline-devel libxslt libxslt-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel ncurses curl gdbm-devel db4-devel libXpm-devel libX11-devel gd-devel gmp-devel expat-devel xmlrpc-c xmlrpc-c-devel libicu-devel libmcrypt-devel libmemcached-devel libc-client-devel && \
     groupadd fpm && useradd -g fpm -s /sbin/nologin -M fpm
ADD  php-7.2.1.tar.gz /
RUN  mv /php-7.2.1 /php && rm -f /php-7.2.1.tar.gz
WORKDIR /php
RUN ./configure  \
--prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/etc \
--with-iconv-dir \
--with-freetype-dir \
--with-jpeg-dir \
--with-png-dir \
--with-curl \
--with-gd \
--with-zlib \
--with-xmlrpc \
--with-openssl \
--with-gettext \
--with-mhash \
--with-libxml-dir=/usr \
--with-fpm-user=fpm \
--with-fpm-group=fpm \
--with-libdir=lib64 \
--with-pcre-regex \
--with-imap  \
--with-imap-ssl  \
--with-kerberos  \
--with-xsl \
--with-bz2 \
--enable-xml \
--enable-fpm  \
--enable-ftp \
--enable-exif \
--enable-bcmath \
--enable-soap \
--enable-shmop \
--enable-sysvsem \
--enable-sockets \
--enable-inline-optimization \
--enable-mbregex \
--enable-mbstring \
--enable-pcntl \
--enable-zip \
--enable-session \
--enable-ctype \
--enable-calendar \
--disable-rpath \
--enable-opcache \
--with-zlib-dir \
--enable-mysqlnd \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd && \
make -j 4 && make install && \
cp php.ini-production /usr/local/php/etc/php.ini && \
cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.conf && \
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm && \
chmod +x /etc/init.d/php-fpm

###start service###
ADD    init.sh /
RUN    chmod 744 /init.sh
EXPOSE 22 80 443
ENTRYPOINT ["/init.sh"]

