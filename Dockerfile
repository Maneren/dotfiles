# create manjaro image for testing

FROM manjarolinux/base:latest as base

ARG TARGETPLATFORM

ARG CACHEBUST=1
ENV LANG=en_US.UTF-8

ENV PATH="/usr/bin:${PATH}"

RUN uname -m && \
  pacman-key --init && \
  pacman-mirrors -f 5

RUN [[ "${TARGETPLATFORM}" == "linux/amd64" ]] || exit 0 && \
  pacman -Syy --noconfirm --needed archlinux-keyring manjaro-keyring && \
  pacman-key --populate archlinux manjaro

RUN [[ "${TARGETPLATFORM}" == "linux/arm64" ]] || exit 0 && \
  pacman -Syy --noconfirm --needed archlinuxarm-keyring manjaro-arm-keyring && \
  pacman-key --populate archlinuxarm manjaro-arm

RUN pacman -Sy --noconfirm --needed \
  shadow \
  git \
  git-lfs \
  cmake \
  libseccomp \
  autoconf \
  automake \
  binutils \
  bison  \
  fakeroot \
  file \
  findutils \
  flex \
  gawk \
  gcc \
  gettext \
  glibc \
  xkeyboard-config \
  grep \
  groff \
  gzip \
  libtool \
  m4 \
  make \
  pacman \
  patch \
  pkgconf \
  sed  \
  sudo \
  texinfo \
  lsb-release \
  manjaro-release \
  which && \
  # docker context give real space limits
  sed -i -e 's~CheckSpace.*~#CheckSpace~g' '/etc/pacman.conf' && \
  pacman -Syyu --noconfirm --needed

RUN ls /etc/*-release && cat /etc/*-release

RUN id -u test_user &>/dev/null || (useradd -ms /bin/bash test_user && \
  echo "test_user ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers)

USER test_user

RUN mkdir /home/test_user/Downloads
