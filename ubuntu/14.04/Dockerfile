# Dockerfile for Ubuntu 14.04
FROM ubuntu:14.04
MAINTAINER Bert Van Vreckem <bert.vanvreckem@gmail.com>

# Install Ansible
RUN apt-get update; \
    apt-get install -y software-properties-common git; \
    apt-add-repository -y ppa:ansible/ansible; \
    apt-get update; \
    apt-get install -y ansible python-netaddr; \
    echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts; \
    echo "[defaults]\nretry_files_enabled = False" > /etc/ansible/ansible.cfg


