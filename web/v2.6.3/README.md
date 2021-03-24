# Discourse Web

This folder contains the Dockerfile which will build the Discourse web container, which includes:

- Frontend javascript code
- Ruby server that backs the frontend
- Sidekiq background workers
- NGINX server

While we don't normally need Nginx to deploy applications on Render, the official Discourse setup is highly-coupled with NGINX, and we have chosen to change as little source code as possible to have a maintainable Render deployment.

For your reference, this is the [NGINX config file](https://github.com/discourse/discourse/blob/v2.6.3/config/nginx.sample.conf) provided by Discourse, which is used in this container build.

**Note:** `install-nginx.sh` is a raw copy of Discourse's official [install-nginx](https://github.com/discourse/discourse_docker/blob/master/image/base/install-nginx) script. It builds NGINX from source to add the [brotli](https://github.com/google/brotli) compression submodule.

# Resource Optimization

We have configured the following:
- [web server](puma.rb): uses 2 workers and 4 threads
- [background worker](sidekiq.yml): concurrency level 2

This seems to work fine on a machine with 2 GB RAM, but you can choose a larger web server plan.
For reference, see the Discourse [default server config](https://github.com/discourse/discourse/blob/v2.6.3/config/puma.rb) and [default worker config](https://github.com/discourse/discourse/blob/v2.6.3/config/sidekiq.yml). These may work better on machines with more RAM.

# Upgrading

This container deploys [Discourse v2.6.3](https://github.com/discourse/discourse/releases/tag/v2.6.3), which is the latest stable version at the time of writing.

Upgrading should be relatively simple since Render will persist assets on [Disks](https://render.com/docs/disks) and persist application data in our [Database](https://render.com/docs/databases) between deploys. However, we will need to add and test the next version to this repo to ensure the build is still correct. Once that is done, all you need to do is upgrade the Dockerfile path in the [render.yaml](../../render.yaml#L19-L20).
