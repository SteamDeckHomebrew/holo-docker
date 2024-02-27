FROM docker.io/spkane/holo-base:latest

RUN pacman -Sy --noconfirm rustup && rustup install stable
