# Dockerfile for Arch Linux
# Doesn't work yet: Need to get Systemd running inside the container...
FROM base/archlinux
MAINTAINER Bert Van Vreckem <bert.vanvreckem@gmail.com>

RUN \
  pacman --sync --refresh --noconfirm --sysupgrade; \
  pacman --sync --refresh --noconfirm ansible; \
  echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts; \
  echo "[defaults]\nretry_files_enabled = False" > /etc/ansible/ansible.cfg

CMD ['/lib/systemd/systemd']
