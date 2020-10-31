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

##compile tomcat####
ADD   jdk-15_linux-x64_bin.tar.gz /
ADD   apache-tomcat-9.0.38.tar.gz /
RUN   mkdir /usr/local/java && mv /jdk-15 /usr/local/java/ && rm -f /jdk-15_linux-x64_bin.tar.gz && \
      mkdir /usr/local/tomcat && mv /apache-tomcat-9.0.38 /usr/local/tomcat/ && rm -f /apache-tomcat-9.0.38.tar.gz && \
      echo 'export JAVA_HOME=/usr/local/java/jdk-15/' >>/root/.bashrc && \
      echo 'export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH' >>/root/.bashrc && \
      echo 'export CLASSPATH=.$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$JAVA_HOME/lib/tools.jar' >>/root/.bashrc && \
      echo 'export TOMCAT_HOME=/usr/local/tomcat/apache-tomcat-9.0.38/' >>/root/.bashrc
ADD test.jsp /usr/local/tomcat/apache-tomcat-9.0.38/webapps/ROOT/test.jsp

##start service##
ADD    init.sh /
RUN    chmod 744 /init.sh
EXPOSE 22 80 443
ENTRYPOINT ["/init.sh"]
