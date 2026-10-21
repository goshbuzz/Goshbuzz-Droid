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
| 10 | Docs site **online** | T0.2 | not started | Owner chooses hosting; keep it static, no third-party scripts or fonts |
| 11 | Threat model v1 | T0.3 | draft ready | Owner review, then sign off in §9 of the doc |
| 12 | Network-connections document | T0.4 | template ready | Real rows require a build, so this completes in Phase 2 (T2.6) |
| 13 | Test phone chosen | T0.5 | **decided: none for now** | No budget. Phase 1 runs on the emulator. The owner's Tecno Spark is a Lite/tester device, not a build target |
| 14 | Build machine plan | T1.1 | not started | Needs #13 and a budget ceiling |
| 15 | Public repo | — | not public yet | Owner action on GitHub |
| 16 | Matrix room | — | not started | Owner action |

## What the owner must do next (nothing here is destructive)

1. Turn on GitHub Private Vulnerability Reporting for this repository (Settings → Code security).
2. Turn on branch protection for `main`: require the `docs` workflow, and require review before merge.
3. Decide whether the docs site goes on GitHub Pages, Cloudflare Pages, or Netlify — cheapest static option
   that allows no third-party scripts.
4. Optional, free: run the one read-only command block in `test-phone-shortlist.md` §2.5 against the Tecno
   Spark, so we know exactly what that device can do for Lite testing.

## Deliberately not done

No images, no build scripts, no `LICENSE` text, no device database entries. Each of these would either
require a decision the owner has not made or state facts that have not been verified.
