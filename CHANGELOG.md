# Changelog

Format: loose [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) style. No releases yet.

## [Unreleased]

### Added

- Phase 0 static landing page in `installer-web/` (AGPL-3.0-or-later), with an explicit
  nothing-installable notice, documentation and honest-limits links, local CSS, and no JavaScript.
- Static Vercel configuration and deployment/rollback instructions. Production publication and
  production HTTP/browser checks remain pending owner approval.

- Phase 0 documentation skeleton: `docs/index.md`, repository README with honest limits, directory layout
  matching `docs/spec/03_ARCHITECTURE.md` §7.
- `docs/threat-model.md` v1 (draft, T0.3): assets, adversaries, in-scope, partly in-scope, out-of-scope,
  assumptions, residual risks, and a per-release status table.
- `docs/network-connections.md` (T0.4): verified-connection register template plus the list of stock defaults
  to remove in Phase 2.
- `docs/licensing.md` (T0.1, partial): license options with a recommendation; decision pending.
- Governance files: `CONTRIBUTING.md`, `SECURITY.md` (private reporting), `CODE_OF_CONDUCT.md`.
- `docs/spec/` holds the owner's specification pack, imported unmodified.

### Decided

- **License (T0.1):** GPL-3.0-or-later for OS code and tooling, AGPL-3.0-or-later for `installer-web/` and
  `ota-server/`, Apache-2.0 for `docs/` and `device-db/`, GPL-2.0 for per-device kernel trees. Texts verbatim in
  `LICENSES/`; per-directory `LICENSE` markers; reasoning in `LICENSING.md`.
- **Contributions:** DCO 1.1, no CLA (`DCO.md`).
- **Test device (T0.5):** no purchase. Phase 1 targets the Android emulator. The owner's Tecno Spark is a
  Lite-testing device; assessment and the reasons are in `docs/testing/test-phone-shortlist.md` §2.5.

### Not done yet

- Docs site deployment, Matrix room, branch protection and private vulnerability reporting (owner actions).
- Bill of materials for AOSP components and bundled apps.
- Any OS code, image, APK, or download. The informational landing page is not an installer.
