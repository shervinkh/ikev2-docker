FROM shervinkh/my-archlinux
MAINTAINER "Shervin Khastoo" <shervinkh145@gmail.com>

COPY scripts /scripts/
COPY configs /etc/

RUN /update.sh && \
    pacman -S --noconfirm binutils patch systemd autoconf automake libtool gcc pkg-config make fakeroot && \
    useradd -m aur && \
    sudo -u aur gpg --keyserver pgp.mit.edu --recv-keys DF42C170B34DBA77 && \
    /scripts/aur_install.sh strongswan && \
    pacman -Rs --noconfirm binutils patch autoconf automake libtool gcc pkg-config make fakeroot&& \ 
    /cleanup.sh

EXPOSE 9001

