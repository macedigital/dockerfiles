FROM centos:7

ARG NODE_VERSION=6.9.5
ARG NODE_ENV=production
ARG NODE_HOME=/srv
ARG NODE_USER=nobody
ARG NPM_LOGLEVEL=warn

# gpg keys listed at https://github.com/nodejs/node#release-team
RUN export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys \
      9554F04D7259F04124DE6B476D5A82AC7E37093B \
      94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
      FD3A5288F042B6850C66B31F09FE44734EB7990E \
      71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
      DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
      C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
      B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg --verify SHASUMS256.txt.asc \
    && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt.asc | sha256sum -c - \
    && tar -xf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc \
    && rm -R /tmp/* \
    && mkdir -p ${NODE_HOME} && chown -R ${NODE_USER} ${NODE_HOME}

ENV NPM_CONFIG_LOGLEVEL ${NPM_LOGLEVEL}
ENV NODE_VERSION ${NODE_VERSION}
ENV NODE_ENV ${NODE_ENV}
ENV HOME ${NODE_HOME}

WORKDIR ${NODE_HOME}

VOLUME [ "${NODE_HOME}" ]

USER ${NODE_USER}

CMD [ "node" ]
