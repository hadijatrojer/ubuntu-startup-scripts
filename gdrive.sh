#!/usr/bin/env bash
set -euo pipefail

# Ensure mise-managed shims (where rclone lives) are on PATH when launched by systemd.
MISE_SHIMS="${HOME}/.local/share/mise/shims"
if [ -d "${MISE_SHIMS}" ] && [[ ":$PATH:" != *":${MISE_SHIMS}:"* ]]; then
  export PATH="${MISE_SHIMS}:${PATH}"
fi

exec rclone mount GDrive: GDrive --vfs-cache-mode full --dir-cache-time 5000h --vfs-cache-max-age 5000h
