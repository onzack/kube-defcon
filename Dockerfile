FROM alpine:3.6.5
LABEL maintainer=dmlabs
ENV TZ=Europe/Zurich
RUN apk update && \
    apk upgrade && \
    apk add -U tzdata && \
    apk add -U curl && \
    apk add -U jq && \
    rm -f /var/cache/apk/* && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl --output /usr/local/bin/kubectl && \
    addgroup -S collector && adduser -S collector -G collector
COPY ./networkpolicy-collector.sh /usr/local/bin/networkpolicy-collector.sh
RUN chown collector:collector /usr/local/bin/networkpolicy-collector.sh && \
    chmod -R +x /usr/local/bin && \
    echo '*  *  *  *  *    /usr/local/bin/networkpolicy-collector.sh' > /etc/crontabs/collector 
#    chown root:collector /usr/bin/crontab && \
#    chmod g+s /usr/bin/crontab
#USER collector
#WORKDIR /home/collector
CMD crond -l 2 -f
