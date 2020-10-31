###ECS_SSH
FROM    centos:7
RUN     yum install -y openssh-server iproute && sed -i 's|#UseDNS yes|UseDNS no|g' /etc/ssh/sshd_config && ssh-keygen -A && echo 'root:123456'|chpasswd
EXPOSE  22
ENTRYPOINT ["/usr/sbin/sshd","-D"]
