# Phase 0 landing page

Static HTML and CSS, licensed AGPL-3.0-or-later. No dependencies, build step, JavaScript, analytics,
external fonts, device detection, or installation functionality. Documentation links open GitHub only
when followed; they do not fetch resources during page load. Vercel still receives ordinary request
metadata; this is not a claim of zero hosting logs.

## Local preview

From the repository root:

```sh
python3 -m http.server 8000 --bind 0.0.0.0 --directory installer-web
```

This server does not apply the security headers in `vercel.json`; verify those on Vercel after deployment.

## Deployment (owner approval required)

- Project: `goshbuzz-droid`; production alias: `goshbuzz-droid.vercel.app`.
- Set Root Directory to `installer-web`, Framework to Other (`null`), no build/install command,
  and output directory `.`. The configuration is `installer-web/vercel.json`, relative to that root.
- Git production branch stays `main`. On 2026-10-21 the connected tool reported
  `gitProviderOptions.createDeployments: disabled`; pushing alone will not deploy. An explicit
  deployment is required after approval. Do not attach a custom domain.
- Before publication, ensure the Page source link exposes the exact deployed source. Until merged,
  a branch deployment must link to the matching branch/commit, not claim it is on `main`.
- Verify HTTP 200, visible Phase 0 notice, CSS, links, mobile layout, security headers, and a browser
  network trace containing no external fonts/scripts/analytics. Report blocked checks as unverified.
- Rollback: promote the previous deployment in Vercel and restore the previous project settings
  (Root Directory, framework, build/install/output were all `null`). The previous deployment
  `dpl_3V7jAevHmxhW8XmCr8o7uLSTc8qW` is empty, so rollback restores the known 404, not a working page.

The future WebUSB installer remains Phase 3 (T3.4). It must verify image hashes and signatures before
flashing and refuse a mismatched device codename. This landing page does not complete that task.
