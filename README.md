s3backup
===

A simple docker container to create "point in time" backups of an s3 bucket
into another s3 bucket.

A copy of the "source" s3 bucket is made to the "backup" s3 bucket with objects
being prefixed with a "path" of `YYYY/MM/DD/YYYY-MMM-DDTHH:MM:SSZ`.  This is
intended to allow multiple backups to be made into the same "backup" bucket
over a period of time.

Usage
===

__The "source" and "backup" buckets must exist before this container will
function.__

All configuration is supplied via environment variables.

Example
---

```sh
docker run \
  -e AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
  -e AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
  -e S3_SRC_BUCKET=example.org \
  -e S3_BACKUP_BUCKET=example.org-backup \
  -e DRYRUN=true \
  lsstsqre/s3backup:latest
```

Would result in recursive copy of all objects under `s3://example.org` to `s3://example.org-backup/2017/04/28/2017-04-28T20:24:26Z`.

Env Vars
===

A number of environment variables are supported to configure the backup
operation.  Several of this are required/mandatory for operation while a few
are optional.

Required
---

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`

AWS access credentials

* `S3_SRC_BUCKET`

The s3 bucket to copy/backup.

This should be the bare bucket name and /not/ in URL form (Ie.,
`s3://example.org`).

* `S3_BACKUP_BUCKET`

The destination s3 bucket to which backups are made.

This should be the bare bucket name and /not/ in URL form (Ie.,
`s3://example.org`).

Optional
---

* `S3_SRC_PREFIX`

An optional path to recursively copy from /instead of/ copying all objects
under the root of the bucket. Eg., `mydir/foo/bar`

* `S3_BACKUP_PREFIX`

An option path to pre-pend to the generated date/time object path prefix. Eg, A
value of `foobar` would result in objects being copied under the path
`s3://example.org-backup/foobar/2017/04/28/2017-04-28T20:24:26Z`.

* `DRYRUN`

Noop / print commands that would be normally be executed.
