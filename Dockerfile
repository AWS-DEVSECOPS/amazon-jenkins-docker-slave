RUN yum update && \
    yum install -q -y git && \
# Install a basic SSH server
    yum install -q -y openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && /usr/bin/ssh-keygen -A && \
    mkdir -p /var/run/sshd && \
# Install JDK 11
    yum install -q -y java-11 && \
# Install maven
    yum install -q -y maven && \
# Install LSOF
        yum install -q -y lsof && \
# Cleanup old packages
    yum clean all && \
# Add user jenkins to the image
    adduser jenkins && \
# Set password for the jenkins user (you may want to alter this).
    echo "jenkins:password" | chpasswd && \
    mkdir /home/jenkins/.m2 && \
        mkdir /home/jenkins/.m2/repository
RUN chown -R jenkins:jenkins /home/jenkins/.m2/
# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
