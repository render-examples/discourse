# Deploy Discourse on Render

This repo can be used to deploy [Discourse] on Render and will create the following components:

- Creates a [Docker-based Web Service](https://render.com/docs/docker) that runs the discourse website and background workers
- Creates a [Render PostgreSQL Managed Database](https://render.com/docs/databases)
- Creates a [Redis](https://render.com/docs/deploy-redis) instance for caching and acting as a message queue for the background workers

## Deployment

### One Click

Use the button below to deploy Discourse on Render.

[![Deploy to Render](http://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

Discourse does *not* work without an email server.  Currently, Render doesn't support email protocols (SMTP), so you will have to use a third-party email provider.
See [below](#recommended-email-providers) for recommended third party email servers.

You will need to provide these environment variables:

- `DISCOURSE_ADMIN_EMAIL` (required): a valid email address for the admin account. Your password will be autogenerated to ensure it passes Discourse validation, and you can view it in the ENV variables section.
- `DISCOURSE_SMTP_ADDRESS` (required): e.g. smtp.mailgun.org
- `DISCOURSE_SMTP_DOMAIN` (required): e.g. mg.example.com
- `DISCOURSE_SMTP_PORT` (required): e.g. 587
- `DISCOURSE_SMTP_USER_NAME` (required): e.g. postmaster@mg.example.com
- `DISCOURSE_SMTP_PASSWORD` (required)
- `CUSTOM_DOMAIN` (optional): the [custom domain](https://render.com/docs/custom-domains) name you will use for this service. If you set this, you will need to configure the DNS before the application is usable
- `DISCOURSE_MAXMIND_LICENSE_KEY` (optional): [GeoLite2](https://dev.maxmind.com/geoip/geoip2/geolite2/) license key, which you can use for user analytics

### Setup

After deploying the service, you will be able to log in with your admin email address.  The password will be located in the environment variables section, under `DISCOURSE_ADMIN_PASSWORD`.

Once you log in successfully, you will be able to run the Discourse setup wizard to customize your Discourse community.

## Recommended email providers

See the official [Discourse recommended email providers](https://github.com/discourse/discourse/blob/master/docs/INSTALL-email.md).

The Render deploy has been fully tested with [Mailgun](https://www.mailgun.com/), but the other providers should work equally as well.

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

This is not an official Discourse deployment method, so you will not receive support directly from Discourse.  See the official [install guide](https://github.com/discourse/discourse/blob/master/docs/INSTALL.md) for more details.

This deployment has several advantages over the Discourse installation, however, including out-of-the-box SSL, dedicated hosts for each component (i.e. more production-ready), a free Render domain, and, of course, support from Render. Oh, and did we mention 1-click deploy?

If you need more help, talk with us at https://community.render.com.

[Discourse]: https://www.discourse.org