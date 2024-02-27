ARG image_name

FROM ${image_name}

RUN pacman -Sy --noconfirm rustup && rustup install stable
