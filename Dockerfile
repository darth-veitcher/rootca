FROM alpine

RUN apk --update add ca-certificates curl openssl

ADD ./bin/* /usr/bin/

ENTRYPOINT [ "/usr/bin/gen-certs" ]
CMD [ ]