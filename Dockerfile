FROM mono:5
ENV REFRESHED_AT 2020-04-18

RUN apt-get update -y \
    && dpkg --add-architecture i386 \
    && apt-get dist-upgrade -y
    
RUN apt-get update -y \
    && apt-get install -y wget lib32gcc1 gosu

RUN mkdir -p /usr/local/bin \
    && cd /usr/local/bin \
    && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - \
    && chown 0.0 -R /usr/local/bin \
    && chmod 0755 /usr/local/bin/steamcmd.sh \
    && chmod 0755 /usr/local/bin/linux32/steamcmd \
    && chmod 0755 /usr/local/bin/linux32/steamerrorreporter

RUN /usr/local/bin/steamcmd.sh +quit

RUN mkdir -p /srv/eco

COPY *.sh /
RUN chmod 0755 /*.sh

COPY update.steam /update.steam

USER 1000

WORKDIR /srv/eco
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/steam.sh" ]
EXPOSE 3000/udp 3001/tcp

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.vendor=Flow86 \
      org.label-schema.license=MIT \
      org.label-schema.description="ECO game server" \
      org.label-schema.docker.cmd="docker run -d -p 3000:3000/udp -p 3001:3001/tcp -v eco:/srv/eco eco"
