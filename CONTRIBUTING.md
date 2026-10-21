# Contributing to GoshBuzz OS

Thank you for considering it. This project is small, unfunded, and careful about what it accepts. Please read
this page before opening a pull request; it will save us both time.

## The rules we do not bend

1. **No Google proprietary code or apps.** No Play Store, GMS, Google apps, or ties to Google infrastructure
   in a distributed image.
2. **No telemetry, analytics, crash reporting, or identifier collection by default.** Opt-in only, and the
   user must see exactly what will be sent before it is sent.
3. **Every network call must be documented** in [docs/network-connections.md](docs/network-connections.md)
   in the same pull request. Undisclosed connections are treated as bugs, even in otherwise good features.
4. **No secrets in the repository.** No signing keys, API keys, accounts, or tokens. Secrets live in a
   secrets manager; signing keys live offline.
5. **No weakening of security defaults.** Do not disable encryption, verified boot, SELinux, or sandboxing to
   make a feature convenient. A user may opt in to a weaker setting, with a warning; we may not change the
   default.
6. **No new exploits.** Bootloader work uses only official vendor methods or publicly documented methods
   from established ROM communities, on devices the person owns.
7. **No proprietary blobs redistributed** unless the license clearly allows it. Prefer scripts that extract
   blobs from the user's own device or from official vendor firmware.
8. **No overclaiming.** If a feature reduces a risk without removing it, the docs and UI say so.

## Licensing of your contribution

The project license is **not chosen yet** — see [docs/licensing.md](docs/licensing.md). Until `LICENSE`
exists, do not send large code contributions; small fixes, docs, and test reports are welcome and will be
re-licensed once the decision is made and contributors are asked to confirm.

Expect a **DCO** (`Signed-off-by` in each commit), not a CLA, if the recommendation is followed.

## What we need most right now (Phase 0/1)

- Corrections to facts in `docs/spec/`, with a link to the source you verified them against.
- Test reports: which phone, which Android version, what works, what breaks.
- Device research for the test-phone shortlist (see T0.5).
- Documentation: plain-language explanations for people who have never flashed a phone.

## What we cannot accept yet

- Large features before Phase 0 exit criteria are met (see [docs/spec/05_ROADMAP.md](docs/spec/05_ROADMAP.md)).
- Prebuilt binaries or images of unknown provenance. Everything we ship must be reproducible from source we publish.
- Changes that add a dependency we cannot audit or maintain.

## How to send a change

1. Open an issue first for anything bigger than a typo. Say what problem it solves.
2. Fork, branch, commit in small logical steps, and sign off: `git commit -s`.
3. Open a pull request. Describe what you tested and on what device.
4. Docs changes: keep Markdown simple, use tables and short sentences, and update
   [docs/index.md](docs/index.md) if you add a page.

## Reporting bugs

- Functional bug: open an issue with phone model, build ID, and exact steps.
- Security bug: **do not** open an issue. Follow [SECURITY.md](SECURITY.md).

## Style

- Plain language. Define jargon the first time you use it (bootloader, GSI, Treble, AVB, SELinux).
- Prefer the honest sentence over the impressive one.

## Response times

This is a volunteer project. A week is a normal response time; longer is possible. Security reports are
prioritised (see [SECURITY.md](SECURITY.md)).
