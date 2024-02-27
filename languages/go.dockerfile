FROM docker.io/spkane/holo-base:latest

RUN pacman -Sy --noconfirm go go-tools
