#!/usr/bin/env bash
set -euo pipefail

DROPBOX_BIN="/usr/bin/dropbox"
DROPBOX_HOME="${HOME}/.dropbox-personal"

if [ ! -x "${DROPBOX_BIN}" ]; then
  echo "Dropbox CLI not found at ${DROPBOX_BIN}" >&2
  exit 1
fi

mkdir -p "${DROPBOX_HOME}"
export HOME="${DROPBOX_HOME}"

exec "${DROPBOX_BIN}" start -i
