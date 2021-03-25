# frozen_string_literal: true

if ENV['RAILS_ENV'] == 'production'

    # Depending on resources, you can choose how many threads that you are going to run at same time.
    workers 2
    threads 4, 16

    # Unless you know what you are changing, do not change them.
    APP_ROOT = '/var/www/discourse'
    bind "unix://#{APP_ROOT}/tmp/sockets/nginx.http.sock"
    stdout_redirect "#{APP_ROOT}/log/puma.log", "#{APP_ROOT}/log/puma.err.log"
    pidfile "#{APP_ROOT}/tmp/pids/puma.pid"
    state_path "#{APP_ROOT}/tmp/pids/puma.state"
    preload_app!

  end
