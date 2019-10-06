FROM python:3.7.4-alpine3.10

RUN apk --upgrade --no-cache --virtual build.deps add \
    curl-dev \
    build-base \
  && pip install --no-cache-dir \
    tornado \
    pycurl \
    nvchecker \
  && apk del build.deps

ENTRYPOINT ["nvchecker"]
