FROM ghcr.io/steamdeckhomebrew/holo-base:latest

ENV RUSTUP_HOME=/.rustup
ENV CARGO_HOME=/.cargo

RUN mkdir /.rustup && chmod -R 777 /.rustup
RUN mkdir /.cargo && chmod -R 777 /.cargo
RUN pacman -Sy --noconfirm rustup && rustup install stable
