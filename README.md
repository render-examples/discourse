# Deploy Discourse on Render

[Discourse](https://www.discourse.org) is modern software for your community. Use it as a mailing list, discussion forum, long-form chat room, and more. You can use this repo to self-host Discourse on Render in just a few clicks!
It will create the following components on Render:
- A [Dockerized Web Service](https://render.com/docs/docker) that runs the Discourse website and background workers.
- A [Render PostgreSQL Managed Database](https://render.com/docs/databases).

## Deployment
### Prerequisites

Discourse does *not* work without an email server. Setting up and managing mail servers can be tricky, so we've omitted a mail server from the deploy config and strongly recommend using a third-party email provider.

See the official [Discourse recommended email providers](https://github.com/discourse/discourse/blob/master/docs/INSTALL-email.md).

We have tested this repo successfully with [Mailgun](https://www.mailgun.com/), but other providers in the list above should work equally well.

### One Click

Use the button below to deploy Discourse on Render.

[![Deploy to Render](http://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

### Manual

See the guide at https://render.com/docs/deploy-discourse.

If you need help, get in touch at https://community.render.com.
