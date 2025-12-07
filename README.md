# Login-Scoped cloud services

This directory contains the helper scripts and systemd user units used to start
my Google Drive mount (via rclone) and a separate personal Dropbox instance.
Both services should run from `$HOME` and only while I'm logged in, so they use
user-level systemd units instead of system services.

## Files

- `gdrive.sh` – mounts the `GDrive:` rclone remote into `~/GDrive`
  (foreground `rclone` process) and prepends the mise shims directory to `PATH`
  so the managed `rclone` binary is available even from systemd.
- `sync-personal-dropbox.sh` – launches `~/.dropbox-dist/dropboxd` with `HOME`
  redirected to `~/.dropbox-personal`, ensuring the directory exists and
  failing fast if the daemon binary is missing.
- `gdrive.service` – user unit wrapper for `gdrive.sh`.
- `dropbox-personal.service` – user unit wrapper for
  `sync-personal-dropbox.sh`.

## Installation

1. Copy the unit files into the user unit directory (create it if needed):
   ```bash
   install -Dm644 gdrive.service dropbox-personal.service dropbox-work.service ~/.config/systemd/user/
   ```
2. Tell systemd about the new units:
   ```bash
   systemctl --user daemon-reload
   ```
3. Enable and start both services for the current user session:
   ```bash
   systemctl --user enable --now gdrive.service dropbox-personal.service dropbox-work.service
   ```

The services are tied to `graphical-session.target`/`xdg-desktop-autostart.target`,
so they will start only after GNOME finishes bringing up the desktop (ensuring the
Dropbox tray icon can appear) and will stop automatically when you log out.

## Verifying/Debugging

- Check status:
  ```bash
  systemctl --user status gdrive.service dropbox-personal.service dropbox-work.service
  ```
- View logs:
  ```bash
  journalctl --user -u gdrive.service -u dropbox-personal.service -u dropbox-work.service -f
  ```
