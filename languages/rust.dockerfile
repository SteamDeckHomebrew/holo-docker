ARG image_name

FROM ${image_name}

ENV RUSTUP_HOME=/.rustup
ENV CARGO_HOME=/.cargo

RUN mkdir /.rustup && chmod -R 777 /.rustup
RUN mkdir /.cargo && chmod -R 777 /.cargo

RUN pacman -Sy --noconfirm rustup && rustup install stable

