FROM    slothds/debian-svd:stretch

LABEL   maintainer="sloth@devils.su"

ENV     WDMRC_VERS=1.10.5.7
ENV     WDMRC_HOME=/opt/home/wdmrc

COPY    rootfs /

RUN     apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
        echo 'deb http://download.mono-project.com/repo/debian stable-stretch main' > /etc/apt/sources.list.d/mono-official.list && \
        apt update && apt -y upgrade && \
        apt -y install --no-install-recommends wget unzip mono-runtime mono-devel && \
        apt -y autoremove && apt -y autoclean &&\
        apt -y clean && apt -y clean all && \
        rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
RUN     wget --no-check-certificate https://github.com/yar229/WebDavMailRuCloud/releases/download/${WDMRC_VERS}/WebDAVCloudMailRu-${WDMRC_VERS}-dotNet461.zip -O /tmp/wdmrc-core.zip && \
        mkdir -p ${WDMRC_HOME} && \
        unzip /tmp/wdmrc-core.zip -d ${WDMRC_HOME} && \
        chown -R runner:runner ${WDMRC_HOME} && \
        rm -f /tmp/*

EXPOSE  8010
