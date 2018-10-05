# Dockerfile for CentOS 6
FROM centos:6
MAINTAINER Bert Van Vreckem <bert.vanvreckem@gmail.com>

# Install Ansible
RUN yum -y update; yum clean all; yum -y install epel-release; \
    yum -y install git ansible sudo libselinux-python python-netaddr python-jinja2; \
    yum clean all; \
    sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers; \
    echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts; \
    echo -e '[defaults]\nretry_files_enabled = False\nstdout_callback=yaml' > /etc/ansible/ansible.cfg

CMD ["/usr/sbin/init"]

