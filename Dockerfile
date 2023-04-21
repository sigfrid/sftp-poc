FROM ruby:3.2.2-alpine3.17 as builder

RUN apk update && \
    apk --no-cache add git build-base libffi-dev

WORKDIR /app

# Install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN bundle config --local frozen 1 && \
    bundle install -j4 --retry 3 && \
    # Remove unneeded gems
    bundle clean --force && \
    # Remove unneeded files from installed gems (cached *.gem, *.o, *.c)
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

######################

FROM ruby:3.2.2-alpine3.17

WORKDIR /application

# Copy app with gems from former build stage
# COPY --chown=someuser:somegroup /source-folder /dest-folder
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY . /application
