# Network connections register

Task T0.4. Status: **template with unverified rows — no measurement has been done yet.**
Filled in during Phase 2 (T2.1, T2.6) and updated in every release.

## Why this exists

Privacy by default means a user can read exactly what their phone talks to, without trusting us. If a
connection is not in this table, it is a bug. The rule: **every connection the OS makes is either removed,
switched off by default, or listed here with a way to disable it.**

## How a row gets verified

A row is only marked `verified` after we have observed it ourselves:

1. Flash a fresh build, do not sign in to anything, do not install apps.
2. Capture traffic from the device, not the app: run a capture on the router with the device's MAC (or a
   hotspot the device is the only client of) for at least 24 hours, including one reboot.
3. Record destination host/IP, port, protocol, payload purpose, and the PID/process on device where possible.
4. Repeat with location off, with location on, and with each optional feature toggled.
5. Store raw captures as evidence (not in Git if large; publish a hash and a location).

Do not mark a row `verified` based on source code reading alone. Source reading says what should happen;
capture says what does.

## Table

`Default` = state on a fresh boot with no user interaction. `Verified` = date of the capture, or `not yet`.

| Component | Destination | Purpose | Default | How to disable | Verified |
|---|---|---|---|---|---|
| Connectivity check (captive portal probe) | TBD | Detects whether a Wi-Fi network needs sign-in | TBD | TBD | not yet |
| Captive portal login | TBD | Portal page fetch | TBD | TBD | not yet |
| NTP time sync | TBD | Clock accuracy | TBD | TBD | not yet |
| DNS resolver | TBD | Name resolution for all apps | TBD | TBD | not yet |
| SUPL / assisted GPS | TBD | Faster GPS fix (leaks location) | TBD | Location gate | not yet |
| microG: push | TBD | App push notifications | off until enabled | microG settings | not yet |
| microG: location backend | TBD | Network location provider | off until enabled | microG settings | not yet |
| microG: self-check / version check | TBD | Update check | TBD | microG settings | not yet |
| OTA update client | TBD (our server) | Security and feature updates | TBD | Updates toggle | not yet |
| Remote wipe / locate service | TBD (our server, opt-in) | Find or wipe a lost device | off | Settings | not yet |
| Emergency calling (E911/112) | Carrier network | Calls emergency services | on, not disableable | n/a — required by law and safety | not yet |
| Bluetooth / Wi-Fi scanning | none until enabled | Location inference when scanning is on | off | Turn off scanning | not yet |
| Default apps (browser, keyboard, messenger, maps, store) | varies | App function; each app's first-run behaviour must be listed | n/a | Per-app firewall | not yet |
| Vendor HALs (per device) | varies | Radio, camera, sensors via vendor blobs | on | Not user-disableable; documented per device | not yet |

## Known planned removals (Phase 2, T2.1)

These are the stock AOSP defaults that must be replaced or removed. Destinations are left as
`verify against the pinned AOSP tag` on purpose: do not paste in a hostname from memory, confirm it in the
source tree you actually build.

| Stock default | Why it is removed or replaced | Replacement criteria |
|---|---|---|
| Connectivity check to Google | Hides usage from Google, ties the OS to Google infrastructure | Operator-agnostic, static, no logging, no account |
| Captive portal to Google | Same | Same |
| NTP to Google time servers | Same | Public pool or our own; must not add a new single point of trust without documentation |
| DNS to Google or carrier | Name-level tracking | Encrypted DNS default, user-changeable, documented resolver list |
| SUPL to vendor/Google | Location leak independent of user consent | Off by default; if a device needs it for GPS, disclose it |

## Rules for contributors

- A pull request that adds a network call **must** add a row here in the same PR.
- A PR that adds an undisclosed call will be rejected, even if the feature is otherwise good.
- Optional features that contact a server must be off by default, and must show the user what is sent.
