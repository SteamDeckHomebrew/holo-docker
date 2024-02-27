ARG image_name

FROM ${image_name}

RUN pacman -Sy --noconfirm go go-tools
