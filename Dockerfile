FROM alpine:3.6.5
LABEL maintainer=dmlabs
ENV TZ=Europe/Zurich
RUN apk update && \
    apk upgrade && \
    apk add -U tzdata && \
    apk add -U curl && \
    apk add -U jq && \
    rm -f /var/cache/apk/* && \
    addgroup -S collector && adduser -S collector -G collector
COPY ./networkpolicy-collector.sh /usr/local/bin/networkpolicy-collector.sh
COPY ./entryscript.sh /usr/local/bin/entryscript.sh
RUN curl -o /usr/local/bin/kubectl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chown -R collector:collector /usr/local/bin/ && \
    chmod -R +x /usr/local/bin
USER collector
WORKDIR /home/collector
ENTRYPOINT ["/usr/local/bin/entryscript.sh"]
