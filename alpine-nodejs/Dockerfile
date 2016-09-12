FROM alpine:edge

ENV NODE_ENV production
ENV NODE_REPL_HISTORY ""
ENV NPM_CONFIG_PROGRESS 1
ENV NPM_CONFIG_LOGLEVEL warn
ENV HOME /srv

RUN apk -U --no-cache add nodejs && chown nobody ${HOME}

USER nobody

WORKDIR ${HOME}

VOLUME [ "${HOME}" ]

CMD [ "node" ]
