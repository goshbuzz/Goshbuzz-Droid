# GoshBuzz OS

A free, open-source, privacy-first mobile operating system based on the Android Open Source Project (AOSP).
No Google code in the base image. Location stays off until you turn it on. Every network connection the
system makes is documented.

> **Status: Phase 0 (Foundations). Nothing is installable yet.**
> There are no images, no downloads, and no supported devices. Do not flash anything from this project.
> See [docs/spec/05_ROADMAP.md](docs/spec/05_ROADMAP.md) for the phase plan and exit criteria.

## What this is

GoshBuzz OS is built in tiers, because no single image can run on every phone:

| Tier | Name | What it is | Needs |
|---|---|---|---|
| 0 | **GoshBuzz Lite** | An app that gives real privacy gains with no flashing, no root, no unlocked bootloader | Any reasonably recent phone |
| 1 | **GoshBuzz GSI** | A generic system image for Treble phones | Unlocked bootloader, Android 8+ class device |
| 2 | **Device builds** | Per-device images with deeper hardening and verified-boot support | Unlocked bootloader, a maintainer |
| 3 | **Legacy builds** | Per-device builds for Android 5–7 era phones | Unlocked bootloader, best-effort security |
| 4 | **Pre-flashed phones** | Devices shipped ready to use (optional, much later) | A business model |

Full detail: [docs/spec/03_ARCHITECTURE.md](docs/spec/03_ARCHITECTURE.md) and
[docs/spec/04_INSTALLER_SPEC.md](docs/spec/04_INSTALLER_SPEC.md).

## What this is not

We will not overclaim. In particular:

- **A phone on a cellular network can always be located by the carrier** through cell towers. This software
  reduces leaks; it cannot remove that.
- **The baseband/modem is closed source.** It can be isolated and restricted, not audited.
- **A VPN moves trust to the VPN provider.** Tor is slower and breaks some apps.
- **Old phones (Android 5–7) have outdated kernels and no vendor updates.** Security there is best-effort
  and the project says so on every download page.
- **Phones with permanently locked bootloaders may never be supported** by a full install. Lite is the path for them.
- **Some apps (banking, some messengers, DRM) may refuse to run** on a modified system. microG and optional
  sandboxed Google Play improve this but cannot guarantee it.
- **No software can promise perfect privacy or security.**

The maintained list of what is and is not mitigated lives in [docs/threat-model.md](docs/threat-model.md).

## Project facts

- **Name:** GoshBuzz OS (working name). "Android" is a Google trademark and never appears in our product
  name or branding; we describe the project as "based on the Android Open Source Project".
- **License:** GPL-3.0-or-later for OS code, AGPL-3.0-or-later for the installer and update server,
  Apache-2.0 for docs and device data. Full mapping and reasoning: [LICENSING.md](LICENSING.md).
  Kernel sources for every distributed build are published under GPL-2.0, per device.
- **Contributions:** Developer Certificate of Origin 1.1, no CLA — see [DCO.md](DCO.md).
- **Team:** one developer today. Contributions and device maintainers welcome.
- **Telemetry:** none by default. Optional only, always previewed before sending.

## Repository layout

| Path | Contents |
|---|---|
| `docs/` | User and developer documentation, threat model, network-connections register |
| `docs/spec/` | The project specification pack (source of truth for scope and decisions) |
| `manifest/` | `repo` manifests pinning AOSP plus our patch sets |
| `patches/` | Ordered patch sets, one directory per component |
| `privacy-manager/` | GoshBuzz Privacy Manager app/service |
| `lite/` | GoshBuzz Lite app |
| `installer-web/` | WebUSB installer |
| `installer-desktop/` | Desktop flasher |
| `device-db/` | Per-device definition files that drive the installer |
| `ota-server/` | Static update server configuration |
| `ci/` | Build and verification scripts |
| `tools/` | Signing, hashing, and release helpers |

## Status of the build

Nothing is buildable yet. Phase 1 will start on the Android emulator, because there is no budget for a test
device and the owner's phone (a Tecno Spark) is a Lite-testing target rather than a build target — the reasons
are written out in [docs/testing/test-phone-shortlist.md](docs/testing/test-phone-shortlist.md) §2.5.

## Getting involved

Read [CONTRIBUTING.md](CONTRIBUTING.md). Security issues: [SECURITY.md](SECURITY.md), never a public issue.
This is a volunteer project with no funding, so response times are best-effort.

## Documentation

Start at [docs/index.md](docs/index.md).
