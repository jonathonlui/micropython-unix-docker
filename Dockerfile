FROM alpine
RUN apk add --no-cache libffi
ADD temp/micropython /usr/local/bin/micropython
ADD temp/micropython-lib /root/.micropython
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ENTRYPOINT [ "micropython" ]
