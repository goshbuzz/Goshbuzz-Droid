# Changelog

Format: loose [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) style. No releases yet.

## [Unreleased]

### Added

- Phase 0 static landing page in `installer-web/` (AGPL-3.0-or-later), with an explicit
  nothing-installable notice, documentation and honest-limits links, local CSS, and no JavaScript.
- Static Vercel configuration and deployment/rollback instructions.

### Changed

- **Landing page published** to `https://goshbuzz-droid.vercel.app` on 2026-10-21 with owner
  approval: project Root Directory set to `installer-web` (Framework Other/`null`, no build/install
  command, output directory `.`), then one explicit production deployment (`dpl_3QwW2BmQvh62qQbSVHgXDpXRDjFM`,
  commit `fb1143f`) — Git auto-deployments remain disabled. Verified live: HTTP 200 at `/`, security
  headers exactly as configured in `installer-web/vercel.json` (third-party raw header capture, grade
  A+), CSS served and byte-identical to the repository file, all seven documentation/source links
  return HTTP 200, and the served HTML is byte-identical to `installer-web/index.html` (response
  `etag` matches the source MD5). Rendered mobile layout and an in-browser network capture remain
  **unverified** (no browser in the verification environment); "no external requests" is supported by
  source inspection plus the live `default-src 'none'` CSP, not by a browser network trace.
- Landing-page footer "Page source" link now points at the merged main path
  (`tree/main/installer-web`) instead of the previous session branch, per the AGPL source-link check.
  The deployed bytes are commit `fb1143f`; `main` becomes byte-identical to the deployed page when
  the open pull request merges (auto-deploy is off, so nothing redeploys).
- T1.1 build-host plan (`docs/build-host-plan.md`, no budget): verified AOSP hardware/OS requirements,
  option comparison with approximate (unverified-quote) costs, chosen setup = owner's existing machine
  after a read-only check, and the official Ubuntu package steps. No hardware purchased or rented.
- T1.3-pre AOSP emulator preparation (`docs/testing/emulator-first-boot-prep.md`, `ci/aosp-emulator-build.sh`):
  verified against official AOSP docs on 2026-10-21 — pin `android-17.0.0_r1` (CP2A.260605.016),
  manifest `https://android.googlesource.com/platform/manifest`, target
  `aosp_cf_x86_64_only_phone-aosp_current-userdebug`, Cuttlefish launch via `launch_cvd`. The script
  is committed but **not executed** (no build host yet; the agent environment fails the check by
  design).

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
