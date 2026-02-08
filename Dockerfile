FROM python:3.14.3-alpine3.23 AS wheelbuilder

ENV PYALPM_VERSION 0.11.1

RUN apk --upgrade --no-cache add \
    build-base \
    pacman-dev \
    pkgconf \
    git \
    patchelf \
  && pip install --no-cache-dir \
    meson-python \
    pytest \
    auditwheel \
    ninja \
  && git clone --depth 1 --branch ${PYALPM_VERSION} https://gitlab.archlinux.org/archlinux/pyalpm.git \
  && pip wheel -w /wheelhouse --no-deps --no-build-isolation /pyalpm \
  && auditwheel repair -w /wheelhouse/ /wheelhouse/pyalpm-${PYALPM_VERSION}-cp314-cp314-linux_x86_64.whl --strip \
  && auditwheel show /wheelhouse/pyalpm-${PYALPM_VERSION}-cp314-cp314-musllinux_1_2_x86_64.whl

FROM python:3.14.3-alpine3.23

ENV TORNADO_VERSION 6.5.4
ENV PYCURL_VERSION 7.45.7
ENV NVCHECKER_VERSION 2.20
ENV PACKAGING_VERSION 26.0
ENV AWESOMEVERSION_VERSION 25.8.0
ENV PYALPM_VERSION 0.11.1

COPY docker-entrypoint.sh /
COPY --from=wheelbuilder /wheelhouse/pyalpm-${PYALPM_VERSION}-cp314-cp314-musllinux_1_2_x86_64.whl /tmp/

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
    awesomeversion==${AWESOMEVERSION_VERSION} \
    /tmp/pyalpm-${PYALPM_VERSION}-cp314-cp314-musllinux_1_2_x86_64.whl \
  && apk del build.deps \
  && pip cache purge \
  && rm -f /tmp/pyalpm-${PYALPM_VERSION}-cp314-cp314-musllinux_1_2_x86_64.whl \
  && chmod +x /docker-entrypoint.sh \
  && nvchecker --help

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nvchecker"]
