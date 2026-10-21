# Phase 0 status

Phase 0 exit criteria (from `spec/05_ROADMAP.md`): **repo public, docs skeleton online, build machine ready,
one dedicated test phone chosen.**

Updated 2026-10-21.

| # | Item | Task | Status | Blocker / next action |
|---|---|---|---|---|
| 1 | Project license chosen | T0.1 | **done 2026-10-21** | GPLv3-or-later / AGPLv3 for services / Apache-2.0 for docs+device-db; see `LICENSING.md` |
| 2 | DCO or CLA decided | T0.1 | **done 2026-10-21** | DCO 1.1; see `DCO.md` |
| 3 | `LICENSE` file(s) added | T0.1 | **done 2026-10-21** | `LICENSE` (GPL-3.0) + `LICENSES/` + per-directory markers |
| 4 | `CONTRIBUTING.md` | T0.1 | done | — |
| 5 | `CODE_OF_CONDUCT.md` | T0.1 | done | — |
| 6 | `SECURITY.md` with private reporting | T0.1 | done (draft) | Enable GitHub Private Vulnerability Reporting in repo settings — owner action |
| 7 | Repo layout from architecture §7 | T0.2 | done | Directories exist as placeholders |
| 8 | README with vision and honest limits | T0.2 | done | — |
| 9 | Docs index | T0.2 | done | `docs/index.md` |
| 10 | Docs site **online** | T0.2 | partial | Landing page **published** to `goshbuzz-droid.vercel.app` on 2026-10-21 (owner-approved) and links to GitHub-rendered docs. Not a standalone rendered docs site — that remains open |
| 11 | Threat model v1 | T0.3 | draft ready | Owner review, then sign off in §9 of the doc |
| 12 | Network-connections document | T0.4 | template ready | Real rows require a build, so this completes in Phase 2 (T2.6) |
| 13 | Test phone chosen | T0.5 | **decided: none for now** | No budget. Phase 1 runs on the emulator. The owner's Tecno Spark is a Lite/tester device, not a build target |
| 14 | Build machine plan | T1.1 | plan written 2026-10-21 | `docs/build-host-plan.md`. No machine provisioned: owner must run the read-only host check in §3 of that doc; Phase 0 gate stays open until a host passes it |
| 15 | Public repo | — | public | Confirmed in Vercel Git metadata on 2026-10-21 |
| 16 | Matrix room | — | not started | Owner action |

## What the owner must do next (nothing here is destructive)

1. Turn on GitHub Private Vulnerability Reporting for this repository (Settings → Code security).
2. Turn on branch protection for `main`: require the `docs` workflow, and require review before merge.
3. ~~Approve publication of the static Phase 0 landing page to `goshbuzz-droid.vercel.app`.~~
   **Done 2026-10-21** (approved and published). A rendered documentation site remains separate;
   the landing page links to GitHub docs.
4. Run the read-only build-host check in `docs/build-host-plan.md` §3 on your own PC. It prints
   CPU/RAM/disk and changes nothing. It decides whether Phase 1 can use the machine you already own.
5. Optional, free: run the one read-only command block in `test-phone-shortlist.md` §2.5 against the Tecno
   Spark, so we know exactly what that device can do for Lite testing.
6. Merge the open pull request carrying the publication results and the footer source-link fix. Git
   auto-deploy is off, so merging redeploys nothing; `main` simply becomes byte-identical to the
   already-deployed page.

## Deliberately not done

No images, no AOSP build scripts, no APKs, and no device database entries. License texts already exist.
The static landing page does not add device support or complete Phase 3 installer tasks.

## Landing-page verification (2026-10-21, after publication)

Published with owner approval via one explicit production deployment
(`dpl_3QwW2BmQvh62qQbSVHgXDpXRDjFM`, commit `fb1143f`) after setting Root Directory `installer-web`,
Framework Other (`null`), no build/install command, output directory `.`. Production branch stays
`main`; Git auto-deployments stay disabled; no custom domain attached. Checks below record what was
actually observed — not what was planned.

- **HTTP 200 at `/`: verified.** Third-party raw header capture (securityheaders.com, 2026-10-21
  17:57 UTC) shows `HTTP/2 200`, `content-type: text/html`. Before the settings change, `/` returned
  Vercel's 404 page (no root `index.html` when Root Directory was unset); `/installer-web/index.html`
  served the page at the nested path. `/` now serves the page directly.
- **Serves the landing page: verified.** Live text fetch shows the hero, the commitments, and the
  honest-limits section. The served HTML is **byte-identical** to `installer-web/index.html` at the
  deployed commit: the response `etag` `0b2b8a0618ce18bef1dec9289f44c8e0` equals the MD5 of the
  repository file. That source contains the prominent Phase 0 status card ("Nothing is installable
  yet", "No system images. No APKs. No supported devices.", "Do not flash anything from this
  project."). Text-extraction tools omit `<aside>`/`<footer>` regions; the byte-identity proof is the
  evidence those parts are served. **Visual browser render: unverified** (no browser in this
  environment).
- **CSS: verified served, render unverified.** `/styles.css` serves and its content matches the
  repository `styles.css` exactly; the byte-identical HTML links it locally. Visual rendering was not
  observed in a browser. **Mobile layout: unverified as a render**; source inspection shows the
  `@media (max-width: 850px)` rules (single-column hero, stacked footer, reduced padding) are present
  in the served stylesheet.
- **Security headers: verified live.** Raw capture shows `Content-Security-Policy`, `Referrer-Policy:
  no-referrer`, `X-Content-Type-Options: nosniff`, and `Permissions-Policy: camera=(), microphone=(),
  geolocation=(), usb=()` exactly as in `installer-web/vercel.json`, plus Vercel-managed
  `Strict-Transport-Security`. `X-Frame-Options` is not set; framing is denied by CSP
  `frame-ancestors 'none'` (scanner agrees). Scanner grade A+. Honest note: Vercel sends
  `access-control-allow-origin: *` on static assets by platform default (not configured by us);
  the page is cookie-less static content, but it is a real header on the wire.
- **Documentation links: verified.** All seven external links on the page (docs index, phase-0
  checklist, README honest-limits, threat model, repository, Page source, AGPL-3.0 text) returned
  HTTP 200 when fetched on 2026-10-21.
- **No external fonts, scripts, analytics: source inspection verified, browser capture unverified.**
  Source has no `<script>`, one local stylesheet, a system font stack, and a `data:` favicon; the live
  CSP `default-src 'none'; style-src 'self'` would block any such request. This is source inspection
  plus an enforced CSP — **not** an in-browser network capture, which this environment cannot perform.
- **Source-link (AGPL) check.** The footer "Page source" link now targets the merged main path
  `https://github.com/goshbuzz/Goshbuzz-Droid/tree/main/installer-web` (owner-selected), replacing the
  previous session-branch link. The deployed bytes are commit `fb1143f`; their exact source is at
  `tree/fb1143f.../installer-web` today, and `tree/main/installer-web` becomes byte-identical to the
  deployed page the moment the open PR merges (auto-deploy is off — merging redeploys nothing). Until
  that merge, `main` differs from the deployed bytes by exactly the footer link line being fixed.
- **Rollback, if ever needed:** re-promote the previous deployment `dpl_S1cAtTQS7oCGGCA1mQpR4xTrLYPC`
  (or the older `dpl_3V7jAevHmxhW8XmCr8o7uLSTc8qW`) and restore the prior settings (Root
  Directory/framework/build/install/output all `null`). Both prior deployments serve the known 404
  at `/`, so rollback restores that 404 state, not a working page.

Phase 0 remains open. This publication does not add device support, downloads, or installer
functionality, and it is not a rendered docs site.
