#nginx
FROM centos:7
RUN  yum install -y iproute lrzsz openssh-server gcc pcre-devel openssl-devel zlib-deve make && \
     sed -i 's|#UseDNS yes|UseDNS no|g' /etc/ssh/sshd_config && \
     ssh-keygen -A && echo 'root:123456'|chpasswd
ADD  nginx-1.18.0.tar.gz /
RUN  mv nginx-1.18.0  nginx && \
     rm -f nginx-1.18.0.tar.gz
WORKDIR nginx
RUN  sed -i -e 's/1.18.0//g' -e 's/nginx\//andy/g' -e 's/"NGINX"/"andy"/g' src/core/nginx.h && \
     ./configure --prefix=/usr/local/nginx --with-http_ssl_module && \
     make && make install && \
     /usr/local/nginx/sbin/nginx && \
     echo "daemon off;">>/usr/local/nginx/conf/nginx.conf && \
     yum clean all
ADD    init.sh /
RUN    chmod 777 /init.sh
EXPOSE 22 80 443
#CMD ["systemctl start sshd"]
ENTRYPOINT ["/init.sh"]
