# Deploy Discourse on Render

[Discourse](https://www.discourse.org) is a modern forum software for your community. Use it as a mailing list, discussion forum, long-form chat room, and more. You can use this repo to self-host Discourse on Render in just a few clicks!
It will create the following components on Render:
- A [Dockerized Web Service](https://render.com/docs/docker) that runs the Discourse website and background workers.
- A [Render PostgreSQL Managed Database](https://render.com/docs/databases).
- A [Redis](https://render.com/docs/deploy-redis) instance for caching and acting as a message queue for the background workers.

## Deployment
### Prerequisites

Discourse does *not* work without an email server. Properly sending mail can be tricky, so we've omitted a mail server from the deploy config and strongly recommend using a third-party email provider.

See the official [Discourse recommended email providers](https://github.com/discourse/discourse/blob/master/docs/INSTALL-email.md).

We have tested this repo successfully with [Mailgun](https://www.mailgun.com/), but other providers in the list above should work equally well.

### One Click

Use the button below to deploy Discourse on Render.

[![Deploy to Render](http://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

### Environment Variables

**Required**

These environment variables must be set appropriately for your application to work:

- `DISCOURSE_ADMIN_EMAIL`: a valid email address for the admin account. Your password will be autogenerated to ensure it meets Discourse requirements, and you can view it in the environment variables list after deploy.
- `DISCOURSE_SMTP_ADDRESS`: the address of your SMTP provider (e.g. smtp.mailgun.org).
- `DISCOURSE_SMTP_DOMAIN`: this should be the domain you send emails from (e.g. for `my_email@mg.example.com`, it would be `mg.example.com`).
- `DISCOURSE_SMTP_PORT`: the port your SMTP provider uses to connect (e.g. 587).
- `DISCOURSE_SMTP_USER_NAME`: your SMTP provider username (e.g. postmaster@mg.example.com).
- `DISCOURSE_SMTP_PASSWORD`: your SMTP provider password.

**Optional:**

These environment variables can be used to further customize your deployment. You do not need to set them unless you need their functionality.

- `CUSTOM_DOMAIN`: the [custom domain](https://render.com/docs/custom-domains) you will use for your Discourse instance. If you populate this variable you will need to [configure DNS](https://render.com/docs/configure-other-dns) before your instance is usable. If you leave it blank, your instance will be available on a `.onrender.com` subdomain.
- `DISCOURSE_MAXMIND_LICENSE_KEY`: [GeoLite2](https://dev.maxmind.com/geoip/geoip2/geolite2/) license key, useful for user analytics.

### Setup

After deploying the service, you will be able to log in with your admin email address. The password will be located in the environment variables section, under `DISCOURSE_ADMIN_PASSWORD`.

Once you log in successfully, you will be able to run the Discourse setup wizard to customize your Discourse community.

## Issues

### Created with no admin account

This is likely because the admin email you specified in the env variables is not valid. If this is the case, you can update the `DISCOURSE_ADMIN_EMAIL` env variable, and the server will redeploy and create the account.

If this also fails, you can manually create an admin account by logging onto the web service shell and run the following commands:

```sh
# This will prompt you to input an email and password to create your admin account
bundle exec rake admin:create

# Restart the Discourse server
bundle exec pumactl -P pids/puma.pid restart
```

## Support

This is not an official Discourse deployment method, so you will not receive support directly from Discourse. See the official [install guide](https://github.com/discourse/discourse/blob/master/docs/INSTALL.md) for more details.

This deployment has several advantages over the [Discourse installation](https://github.com/discourse/discourse/blob/master/docs/INSTALL-cloud.md), however, including out-of-the-box SSL, dedicated hosts for each component (i.e. more production-ready), a free Render domain, and, of course, support from Render. Oh, and did we mention 1-click deploy?

If you need more help, talk with us at https://community.render.com.
