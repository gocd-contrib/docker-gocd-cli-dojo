FROM openjdk:8u181-alpine3.8

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# Install common Dojo scripts
ENV DOJO_VERSION=0.4.1
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache tini bash shadow sudo git wget curl nano && \
  git clone --depth 1 -b ${DOJO_VERSION} https://github.com/ai-traders/dojo.git /tmp/dojo_git &&\
  /tmp/dojo_git/image_scripts/src/install.sh && \
  rm -r /tmp/dojo_git

ENTRYPOINT ["/sbin/tini", "-g", "--", "/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

# ensure pretty bash prompt and env. variables are set
COPY profile /home/dojo/.profile
COPY bashrc /home/dojo/.bashrc
RUN chown dojo:dojo /home/dojo/.profile /home/dojo/.bashrc

# Optional scripts to run on container start
COPY etc_dojo.d/scripts/* /etc/dojo.d/scripts/

COPY gocd /usr/bin/gocd
RUN chmod +x /usr/bin/gocd

COPY ./libs/ /home/dojo/.gocd/plugins
RUN chown -R dojo:dojo /home/dojo/.gocd/

ARG this_image_tag_arg
ENV this_image_tag=${this_image_tag_arg}
