

FROM centos:7
MAINTAINER Jade_Lee

RUN yum -y update; yum clean all
RUN yum -y install net-tools openssh-server openssh-clients openssh-askpass passwd python3 wget; yum clean all
RUN mkdir /var/run/sshd
RUN ssh-keygen -q -b 1024 -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -b 1024 -N '' -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -b 521 -N '' -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -q -b 521 -N '' -t ed25519 -f /etc/ssh/ssh_host_ed25519_keyo
RUN mkdir ~/.ssh
RUN cat /etc/ssh/ssh_host_rsa_key >> ~/.ssh/id_rsa
RUN cat /etc/ssh/ssh_host_rsa_key.pub >> ~/.ssh/authorized_keys
RUN sed -i -e 's~^PermitRootLogin no~PermitRootLogin yes~g' /etc/ssh/sshd_config
RUN sed -i -e 's~^PasswordAuthentication no~PasswordAuthentication yes~g' /etc/ssh/sshd_config
RUN sed -i -e 's~^#Port 22~Port 22~g' /etc/ssh/sshd_config
RUN chmod 400 ~/.ssh/id_rsa
RUN echo /usr/sbin/sshd -E /tmp/sshd.log >> /root/.bashrc && source /root/.bashrc
RUN change_root() { ROOT_PW=admin1234; echo -e "$ROOT_PW\n$ROOT_PW" | (passwd --stdin root); echo root password: $ROOT_PW; }; change_root
RUN user_add() { useradd admin; PASSWD=admin1234; echo -e "$PASSWD\n$PASSWD" | (passwd --stdin admin); echo admin password: $PASSWD; }; user_add

ENTRYPOINT ["/usr/sbin/sshd", "-E", "/tmp/sshd.log"]

