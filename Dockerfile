FROM shervinkh/my-archlinux
MAINTAINER "Shervin Khastoo" <shervinkh145@gmail.com>

COPY scripts /scripts/
COPY configs /etc/

RUN /update.sh && \
    pacman -S --noconfirm strongswan && \
    /cleanup.sh

EXPOSE 9001

