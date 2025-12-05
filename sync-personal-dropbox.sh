#!/usr/bin/env bash
set -euo pipefail

DROPBOX_HOME="${HOME}/.dropbox-personal"
DROPBOXD_BIN="${DROPBOX_HOME}/.dropbox-dist/dropboxd"


if [ ! -x "${DROPBOXD_BIN}" ]; then
  echo "Dropbox daemon not found at ${DROPBOXD_BIN}" >&2
  exit 1
fi

mkdir -p "${DROPBOX_HOME}"
export HOME="${DROPBOX_HOME}"

exec "${DROPBOXD_BIN}" "$@"
