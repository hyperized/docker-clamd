# docker-clamd
A simple ClamAV Daemon docker instance based on Alpine

### To pull container

```docker pull hyperized/clamd```

### To build container

```docker build -t hyperized/clamd .```

### To run container 

```docker run -p 3310:3310 hyperized/clamd```

Inspired by: [mko-x/docker-clamav](https://github.com/mko-x/docker-clamav)
