# Dockerfile for Arch Linux
#
# This Dockerfile is based on the one created by merorafael.
# - his Github repo: https://github.com/merorafael/docker-arch-systemd
# - Docker hub: https://hub.docker.com/r/merorafael/arch-systemd/

FROM archlinux/base:latest
MAINTAINER Bert Van Vreckem <bert.vanvreckem@gmail.com>
ENV container docker

# Update Arch
RUN \
  pacman --noconfirm --sync --refresh archlinux-keyring; \
  pacman --noconfirm --sync --refresh pacman pacman-mirrorlist \
    && rm -rf /etc/pacman.d/mirrorlist.pacnew \
    && pacman-db-upgrade \
    && pacman --noconfirm --sync --refresh -u; \
  pacman --noconfirm --sync --refresh systemd systemd-sysvcompat; \
  # Clean services and install Ansible
  (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
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
  pacman --noconfirm --sync --refresh --sysupgrade; \
  pacman --noconfirm --sync --refresh iproute2 ansible python-netaddr; \
  printf "[local]\nlocalhost ansible_connection=local\n" > /etc/ansible/hosts; \
  printf "[defaults]\nretry_files_enabled = False\nstdout_callback = yaml" > /etc/ansible/ansible.cfg

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/bin/init"]

