FROM ubuntu:12.04.5
MAINTAINER Bert Van Vreckem <bert.vanvreckem@gmail.com>
# Install Ansible
RUN apt-get install -y python-software-properties git
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt-get update
RUN apt-get install -y ansible
# Install Ansible inventory file
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

