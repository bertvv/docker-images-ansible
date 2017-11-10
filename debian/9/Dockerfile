# Dockerfile for Debian jessie
FROM debian:stretch
MAINTAINER Bert Van Vreckem <bert.vanvreckem@gmail.com>

# Install Ansible
RUN \
    (cd /lib/systemd/system/sysinit.target.wants/ || exit; for i in *; do [ "$i" = systemd-tmpfiles-setup.service ] || rm -f "$i"; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*; \
    apt-get update; \
    apt-get install -y --no-install-recommends sudo build-essential libffi-dev libssl-dev python-pip python-dev; \
    rm -rf /var/lib/apt/lists/*; \
    rm -Rf /usr/share/doc && rm -Rf /usr/share/man; \
    apt-get clean

RUN pip install ansible cryptography
RUN mkdir -p /etc/ansible; \
    echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts; \
    echo "[defaults]\nretry_files_enabled = False" > /etc/ansible/ansible.cfg

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
