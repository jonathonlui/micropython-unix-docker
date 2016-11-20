FROM alpine
RUN apk add --no-cache libffi
ADD bin/micropython /usr/local/bin/micropython
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ENTRYPOINT [ "micropython" ]
