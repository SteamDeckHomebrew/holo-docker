FROM scratch
ADD ./steamos /
ADD ./steamos/usr/share/factory /
RUN pacman-key --init \
 && pacman-key --populate archlinux \
 && pacman-key --populate holo