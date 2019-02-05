# Dockerfile for Debian stretch
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
    systemctl mask dev-mqueue.mount dev-hugepages.mount \
      systemd-remount-fs.service sys-kernel-config.mount \
      sys-kernel-debug.mount sys-fs-fuse-connections.mount \
      systemd-logind.service getty.service getty.target; \
    apt update; \
    apt install -y software-properties-common git systemd-sysv; \
    echo 'deb http://http.debian.net/debian stretch-backports main' > /etc/apt/sources.list.d/backports.list; \
    apt update; \
    apt -t stretch-backports install -y ansible python-netaddr; \
    rm -rf /var/lib/apt/lists/*; \
    rm -Rf /usr/share/doc && rm -Rf /usr/share/man; \
    apt clean

RUN mkdir -p /etc/ansible; \
    printf "[local]\nlocalhost ansible_connection=local\n" > /etc/ansible/hosts; \
    printf "[defaults]\nretry_files_enabled = False\nstdout_callback = yaml" > /etc/ansible/ansible.cfg

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
