# Discourse Web

This folder contains the Dockerfile which will build the Discourse web container, which includes:

- Frontend javascript code
- Ruby server that backs the frontend
- Sidekiq background workers
- NGINX server
- Redis server

While we don't normally need NGINX to deploy applications on Render, the official Discourse setup is highly coupled with NGINX, and we have chosen to change as little source code as possible to have a maintainable Render deployment.

For your reference, this is the [NGINX config file](https://github.com/discourse/discourse/blob/v2.6.3/config/nginx.sample.conf) provided by Discourse, which is used in this container build.

**Note:** `install-nginx.sh` is a raw copy of Discourse's official [install-nginx](https://github.com/discourse/discourse_docker/blob/master/image/base/install-nginx) script. It builds NGINX from source to add the [brotli](https://github.com/google/brotli) compression submodule.
