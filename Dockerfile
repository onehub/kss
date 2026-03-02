FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    autotools-dev build-essential curl ca-certificates \
    libssl-dev libreadline-dev libffi-dev libyaml-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

ARG OPENSSL=1.0.2
# Build OpenSSL 1.0.2 only when needed (Ruby <2.4 is incompatible with OpenSSL 1.1+)
RUN if [ "$OPENSSL" = "1.0.2" ]; then \
    curl -fSL https://www.openssl.org/source/openssl-1.0.2u.tar.gz | tar -xzC /usr/local/src \
    && cd /usr/local/src/openssl-1.0.2u \
    && ./config --prefix=/opt/openssl-1.0.2 shared \
    && make -j"$(nproc)" \
    && make install_sw \
    && rm -rf /usr/local/src/openssl-1.0.2u; \
    fi

ARG RUBY_MAJOR=1.9
ARG RUBY_VERSION=1.9.3-p551
ARG RUBY_ARCHIVE=bz2

# Download and extract Ruby source
RUN mkdir -p /usr/local/src/ruby \
    && curl -fSL "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR}/ruby-${RUBY_VERSION}.tar.${RUBY_ARCHIVE}" \
        | tar -x$([ "$RUBY_ARCHIVE" = "bz2" ] && echo j || echo z)C /usr/local/src/ruby --strip-components=1

# Patch config.guess/config.sub for aarch64 support, then compile
RUN cp /usr/share/misc/config.guess /usr/local/src/ruby/tool/ \
    && cp /usr/share/misc/config.sub /usr/local/src/ruby/tool/ \
    && cd /usr/local/src/ruby \
    && OPENSSL_DIR=$([ "$OPENSSL" = "1.0.2" ] && echo /opt/openssl-1.0.2 || echo /usr) \
    && ./configure --prefix=/opt/rubies/ruby-${RUBY_VERSION} --disable-install-doc \
        --with-openssl-dir=$OPENSSL_DIR \
    && if [ "$(printf '%s\n' "2.5" "$RUBY_MAJOR" | sort -V | head -n1)" = "2.5" ]; then \
         make -j"$(nproc)"; \
       else \
         make; \
       fi \
    && make install \
    && rm -rf /usr/local/src/ruby

ENV PATH=/opt/rubies/ruby-${RUBY_VERSION}/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/openssl-1.0.2/lib
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

ARG INSTALL_BUNDLER=1.17.3
RUN if [ -n "$INSTALL_BUNDLER" ]; then \
    gem install bundler -v $INSTALL_BUNDLER --no-document 2>/dev/null \
    || gem install bundler -v $INSTALL_BUNDLER --no-rdoc --no-ri; \
    fi

WORKDIR /app
COPY . .

RUN --mount=type=cache,target=/bundle-cache \
    (bundle config set --local path /bundle-cache 2>/dev/null \
      || bundle config --local path /bundle-cache) \
    && (bundle check || bundle install --jobs $(nproc)) \
    && mkdir -p vendor/bundle \
    && cp -a /bundle-cache/. vendor/bundle/ \
    && (bundle config set --local path vendor/bundle 2>/dev/null \
      || bundle config --local path vendor/bundle)
CMD ["bundle", "exec", "rake", "test"]
