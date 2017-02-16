FROM ruby:2.4-alpine

ENV ENTRYKIT_VERSION 0.4.0

# Install Entrykit
RUN apk update \
  && apk add openssl \
  && rm -rf /var/cache/apk/* \
  && wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink


WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN true \
  && adduser -D myuser \
  && chown myuser:myuser -R /app \
  && bundle install --path vendor/bundle

# for heroku
USER myuser

ADD . /app

ENTRYPOINT [ \
  "switch", \
    "shell=/bin/sh", \
  "prehook", "ruby -v", "--", \
  "--", "bundle", "exec", "ruboty"]
 # "codep", "/bin/reloader 3", \

