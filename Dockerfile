FROM alpine:latest

LABEL maintainer="Gerben Geijteman <gerben@hyperized.net>"
LABEL description="A simple ClamAV Daemon docker instance based on Alpine"

RUN apk --no-cache add --update clamav-daemon wget

# Initial update of av databases
RUN wget -O /var/lib/clamav/main.cvd http://database.clamav.net/main.cvd && \
    wget -O /var/lib/clamav/daily.cvd http://database.clamav.net/daily.cvd && \
    wget -O /var/lib/clamav/bytecode.cvd http://database.clamav.net/bytecode.cvd && \
    chown clamav:clamav /var/lib/clamav/*.cvd

# Fix permissions
RUN mkdir /run/clamav && \
    chown clamav:clamav /run/clamav && \
    chmod 750 /run/clamav

# Run in foreground and expose socket
RUN sed -i 's/^#Foreground .*$/Foreground true/g' /etc/clamav/clamd.conf && \
    echo "TCPSocket 3310" >> /etc/clamav/clamd.conf
EXPOSE 3310

# Expose volume so external Freshclam instance can update database
VOLUME ["/var/lib/clamav"]

# Run in foreground
CMD ["/usr/sbin/clamd", "-c", "/etc/clamav/clamd.conf"]
