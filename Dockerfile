FROM python:3.13.3-alpine3.21

ENV TORNADO_VERSION 6.5
ENV PYCURL_VERSION 7.45.6
ENV NVCHECKER_VERSION 2.17
ENV PACKAGING_VERSION 25.0

COPY docker-entrypoint.sh /

RUN apk --upgrade --no-cache add \
    bash \
  && apk --no-cache --virtual build.deps add \
    curl-dev \
    build-base \
  && pip install --no-cache-dir \
    tornado==${TORNADO_VERSION}\
    pycurl==${PYCURL_VERSION} \
    nvchecker==${NVCHECKER_VERSION} \
    packaging==${PACKAGING_VERSION} \
  && apk del build.deps \
  && chmod +x /docker-entrypoint.sh \
  && nvchecker --help

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nvchecker"]
