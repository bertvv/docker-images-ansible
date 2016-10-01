# Dockerfile for Ubuntu 12.04

FROM ubuntu:12.04.5
MAINTAINER Bert Van Vreckem <bert.vanvreckem@gmail.com>

# Install Ansible
RUN \
    apt-get update; \
    apt-get install -y sudo python-software-properties git; \
    apt-add-repository -y ppa:ansible/ansible; \
    apt-get update; \
    apt-get install -y ansible; \
    echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts; \
    echo "[defaults]\nretry_files_enabled = False" > /etc/ansible/ansible.cfg


