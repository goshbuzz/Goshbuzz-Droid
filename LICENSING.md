# Licensing

Decided 2026-10-21 by the project owner. This file is the map; the canonical license texts are in
[`LICENSES/`](LICENSES/).

## The split

| Path | License | SPDX |
|---|---|---|
| `privacy-manager/` | GNU GPL v3, or any later version | `GPL-3.0-or-later` |
| `lite/` | GNU GPL v3, or any later version | `GPL-3.0-or-later` |
| `patches/` | GNU GPL v3, or any later version | `GPL-3.0-or-later` |
| `manifest/` | GNU GPL v3, or any later version | `GPL-3.0-or-later` |
| `tools/` | GNU GPL v3, or any later version | `GPL-3.0-or-later` |
| `installer-web/` | GNU AGPL v3, or any later version | `AGPL-3.0-or-later` |
| `ota-server/` | GNU AGPL v3, or any later version | `AGPL-3.0-or-later` |
| `installer-desktop/` | GNU GPL v3, or any later version | `GPL-3.0-or-later` |
| `device-db/` | Apache License 2.0 | `Apache-2.0` |
| `docs/`, `README.md`, `CHANGELOG.md`, `CONTRIBUTING.md`, `SECURITY.md`, `CODE_OF_CONDUCT.md` | Apache License 2.0 | `Apache-2.0` |
| `ci/` | GNU GPL v3, or any later version | `GPL-3.0-or-later` |
| Per-device kernel trees (separate repositories) | GNU GPL v2 only | `GPL-2.0-only` |

`LICENSE` at the repository root is the full GPL-3.0 text and is the default for anything not listed above.

## Why this split

The owner's instruction was to choose for **maximum security and privacy**. The strongest lever a license
gives a privacy project is not device hardening (no license changes how a phone boots); it is **whether a user
can verify and republish the software they are running**. So:

- **Every part of the OS a user runs is copyleft** (GPL-3.0-or-later): the Privacy Manager, the Lite app, the
  patches, the manifests, the tooling. A vendor cannot take them, add telemetry, close the source, and keep the
  `GoshBuzz` name pointing at it.
- **The two network services are AGPL** (`installer-web/`, `ota-server/`). If someone runs a modified
  "GoshBuzz installer" or "GoshBuzz update server" as a service, users get access to that modified source. This
  matters most for the update server: an update server is the single highest-value place to betray users.
- **Device definitions and docs are Apache-2.0** so other projects, translators, and device maintainers can
  reuse them freely, including in proprietary contexts. Data about how to flash a phone is not a privacy risk;
  restricting it only slows down support for more devices.
- **Kernel: GPL-2.0-only**, unmodified, published per device, because the Linux kernel requires it and offers
  no later-version option we can rely on.

This is stricter than the earlier draft recommendation (which had the Lite app under Apache-2.0). The draft
reasoned that permissive licensing would help Lite spread to phones we cannot fully support. The owner's
priority overrides that: a privacy app that cannot be audited by its users is the wrong trade. Lite under
GPL-3.0-or-later is still free to install, copy, and redistribute for anyone.

## Contributor sign-off: DCO

DCO 1.1, not a CLA. Every commit carries `Signed-off-by: Real Name <email>`; `git commit -s` adds it.
The canonical text governs and is published at <https://developercertificate.org/>. Read it before your first
contribution. It says, in short: you wrote the contribution or have the right to submit it, and you agree it may
be distributed under this project's license.

No CLA means the project cannot relicense your work later without asking you. That is a deliberate cost: it
keeps contributors' work theirs.

## Trademarks are separate from copyright

The code license grants no rights to the **name** "GoshBuzz" or any project logo. A trademark policy is still
needed before the first public release (open decision in
[`docs/spec/02_PROJECT_SPEC.md`](docs/spec/02_PROJECT_SPEC.md)). Until then: forks must use a different name.

## Obligations we accept by this choice

1. **Source availability.** Every binary we distribute, including the Lite APK and the installed system image,
   must have complete corresponding source published, including our patches, at the same version.
2. **Kernel source per device.** Published, tagged per release, for every device build.
3. **Notices.** Keep copyright notices, ship the license texts with the software, and provide the "how to get
   the source" notice in the About screen of the OS and in the app.
4. **No relicensing of bundled apps.** Third-party apps keep their own licenses; we distribute them unchanged
   as separate, unmodified packages wherever possible.
5. **AGPL network services** must offer their source to their users.

## Remaining open questions

- Trademark policy for the name and logo (before first public release).
- Whether `docs/` translations keep the Apache-2.0 license (intended: yes).
- Bill of materials for AOSP components and bundled apps: not started; see `docs/licensing.md` §"What happens
  after the decision".
