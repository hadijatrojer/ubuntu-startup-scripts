#!/usr/bin/env bash
set -euo pipefail

DROPBOXD_BIN="${HOME}/.dropbox-dist/dropboxd"


if [ ! -x "${DROPBOXD_BIN}" ]; then
  echo "Dropbox daemon not found at ${DROPBOXD_BIN}" >&2
  exit 1
fi

exec "${DROPBOXD_BIN}" "$@"
