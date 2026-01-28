FROM python:3.14.2-alpine3.23

ENV TORNADO_VERSION 6.5.4
ENV PYCURL_VERSION 7.45.7
ENV NVCHECKER_VERSION 2.20
ENV PACKAGING_VERSION 26.0
ENV PYALPM_VERSION 0.10.12
ENV AWESOMEVERSION_VERSION 25.8.0

COPY docker-entrypoint.sh /

RUN apk --upgrade --no-cache add \
    bash \
  && apk --no-cache --virtual build.deps add \
    curl-dev \
    build-base \
    pacman-dev \
    pkgconf \
  && pip install --no-cache-dir \
    tornado==${TORNADO_VERSION}\
    pycurl==${PYCURL_VERSION} \
    nvchecker==${NVCHECKER_VERSION} \
    packaging==${PACKAGING_VERSION} \
    pyalpm==${PYALPM_VERSION} \
    awesomeversion==${AWESOMEVERSION_VERSION} \
  && apk del build.deps \
  && chmod +x /docker-entrypoint.sh \
  && nvchecker --help

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nvchecker"]
