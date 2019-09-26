FROM alpine:3.10

RUN apk --update --no-cache upgrade -a \
  && apk --update --no-cache add \
    python3 \
    curl \
    wget \
    grep \
    coreutils \
    tzdata \
  && pip3 install --no-cache-dir --upgrade pip \
  && apk --no-cache --virtual build.deps add \
    curl-dev \
    python3-dev \
    build-base \
  && pip3 install --no-cache-dir \
    tornado \
    pycurl \
    nvchecker \
    requests \
    bs4 \
    dockerfile_parse \
    six \
    dateparser \
  && apk del build.deps \
  && ln -s /usr/share/zoneinfo/Etc/GMT /etc/localtime

CMD ["sh"]
