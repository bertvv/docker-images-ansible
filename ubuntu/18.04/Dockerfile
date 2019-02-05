# Dockerfile for Ubuntu 14.04
FROM ubuntu:18.04
MAINTAINER Bert Van Vreckem <bert.vanvreckem@gmail.com>

# Install Ansible
RUN \
    apt-get update; \
    apt-get install -y systemd; \
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
    apt-get install -y software-properties-common git iproute2; \
    apt-add-repository -y ppa:ansible/ansible; \
    apt-get install -y ansible python-netaddr; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
    printf "[local]\nlocalhost ansible_connection=local\n" > /etc/ansible/hosts; \
    printf "[defaults]\nretry_files_enabled = False\nstdout_callback = yaml\n" > /etc/ansible/ansible.cfg

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
