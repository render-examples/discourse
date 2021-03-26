FROM ruby:2.7.2

ARG RENDER_EXTERNAL_HOSTNAME
ARG CUSTOM_DOMAIN

ENV DISCOURSE_HOSTNAME=${CUSTOM_DOMAIN:-$RENDER_EXTERNAL_HOSTNAME}
ENV RAILS_ENV=production
ENV DISCOURSE_VERSION=v2.6.3
ENV DISCOURSE_ROOT=/var/www/discourse

WORKDIR $DISCOURSE_ROOT

RUN git clone https://github.com/discourse/discourse.git --branch $DISCOURSE_VERSION --single-branch $DISCOURSE_ROOT

RUN apt-get update && apt-get install -y \
    brotli \
    gifsicle \
    jhead \
    jpegoptim \
    nodejs \
    npm \
    optipng \
    pngquant \
    vim
RUN npm install -g svgo
RUN bundle config set path vendor/bundle/ && bundle install
RUN gem install foreman

# Configure NGINX
COPY install-nginx.sh /tmp/install-nginx.sh
RUN /tmp/install-nginx.sh && \
    cp config/nginx.sample.conf /etc/nginx/conf.d/discourse.conf && \
    sed -i "s/^  server_name enter\.your\.web\.hostname\.here;/  server_name $DISCOURSE_HOSTNAME;/" /etc/nginx/conf.d/discourse.conf && \
    mkdir -p /var/nginx/cache/

# Render offers free, fully managed SSL, so set default web setting to force HTTPS
RUN perl -i -p0e 's/  force_https:\n    default: false/  force_https:\n    default: true/' config/site_settings.yml

# Ensure socket, pid, and log files exist
RUN mkdir -p tmp/sockets/ tmp/pids/
RUN touch log/production.log

COPY puma.rb sidekiq.yml ./config/
COPY entrypoint.sh Procfile ./

ENTRYPOINT [ "bash", "entrypoint.sh" ]
