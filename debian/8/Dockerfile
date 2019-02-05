# Dockerfile for Debian jessie
FROM debian:jessie
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
        systemctl mask dev-mqueue.mount dev-hugepages.mount \
      systemd-remount-fs.service sys-kernel-config.mount \
      sys-kernel-debug.mount sys-fs-fuse-connections.mount \
      systemd-logind.service getty.service getty.target; \
    apt-get update; \
    apt-get install -y --no-install-recommends sudo build-essential libffi-dev libssl-dev python-dev python-pip python-netaddr; \
    pip install --upgrade pip setuptools; \
    rm -rf /var/lib/apt/lists/*; \
    rm -Rf /usr/share/doc && rm -Rf /usr/share/man; \
    apt-get clean;

RUN \
    pip install ansible; \
    mkdir -p /etc/ansible; \
    printf "[local]\nlocalhost ansible_connection=local\n" > /etc/ansible/hosts; \
    printf "[defaults]\nretry_files_enabled = False\nstdout_callback = yaml\n" > /etc/ansible/ansible.cfg

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
