# system-updates

Opt-in apt update check and reboot-free upgrade. The same role is used in
several playbooks; keep the copies identical and put host specifics into
`host_vars`/`group_vars`.

| Tag | Effect |
|---|---|
| `--tags updates-check` | Read-only report (only refreshes the apt lists) |
| `--tags updates-apply` | Same report, `apt-get upgrade` without reboot-relevant packages, report of what is left |

Neither tag runs in a plain playbook run (tasks are tagged `never`). The play
has no tag of its own on purpose: a play tag would be inherited by the apply
tasks and start them together with the check.

## Report

- upgradable apt packages, split into "no reboot" / "needs reboot", plus
  security updates and `apt-mark` holds
- pending reboot (running vs. newest installed kernel of the same flavour,
  `/run/reboot-required`)
- services on outdated libraries (only if `needrestart` is installed)
- git checkouts and python venvs listed in the variables below

## updates-apply

1. holds every upgradable package matching `system_updates_reboot_patterns`
   (kernel, firmware, DKMS, microcode, libc, systemd/udev, dbus) and
   `system_updates_extra_hold_patterns`
2. `apt-get upgrade` (no new packages, no removals), keeps local config files
   (`--force-confold`), waits up to 300s for the dpkg lock, `needrestart` only
   lists (`NEEDRESTART_MODE=l`)
3. releases only the holds it set itself

Packages whose new version needs a held or new package are kept back by apt.
Services restarted by their own package scripts (e.g. nginx, sshd, dnsmasq,
docker) do restart; a host reboot never happens.

## Variables

| Variable | Default | Purpose |
|---|---|---|
| `system_updates_reboot_patterns` | see `defaults/main.yml` | regexes for packages that need a reboot |
| `system_updates_extra_hold_patterns` | `[]` | further regexes held by updates-apply, e.g. `'^docker'` |
| `system_updates_git_checkouts` | `[]` | `{name, path}` of git checkouts to compare with their remote |
| `system_updates_pip_venvs` | `[]` | `{name, path}` of venvs to list outdated packages for |
