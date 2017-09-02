# container-base-lumen
Dockerfiles that are base of Laravel Lumen environment.

How to use
====

`run.sh` links `.env.<APP_ENV>` to `.env` as symbolic. So you should prepare following steps.

1. Put `.env.${APP_ENV}` like `.env.local` or `.env.production` on Document root.
2. When run this image's container, set `APP_ENV`.