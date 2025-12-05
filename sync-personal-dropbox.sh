#!/usr/bin/env bash
set -euo pipefail

DROPBOXD_BIN="${HOME}/.dropbox-dist/dropboxd"
DROPBOX_HOME="${HOME}/.dropbox-personal"

if [ ! -x "${DROPBOXD_BIN}" ]; then
  echo "Dropbox daemon not found at ${DROPBOXD_BIN}" >&2
  exit 1
fi

mkdir -p "${DROPBOX_HOME}"
export HOME="${DROPBOX_HOME}"

exec "${DROPBOXD_BIN}" "$@"
