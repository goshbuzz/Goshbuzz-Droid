# Licensing analysis (T0.1 — decided 2026-10-21)

> **This document is now history, not policy.** The decision was made on 2026-10-21 and is implemented in
> [`../LICENSING.md`](../LICENSING.md), with the full license texts in [`../LICENSES/`](../LICENSES/).
> Read that file first. This page is kept because the reasoning behind the choice matters later, when someone
> asks "why GPLv3 and not Apache-2.0?".

Status: **decided.** The owner asked for the option that best serves security and privacy; the implemented
choice is stricter than the recommendation below (Lite moved from Apache-2.0 to GPL-3.0-or-later, and the
installer and update server are AGPL). Rationale: for a privacy project, the value of copyleft is that users
can verify and republish what they run, and a privacy app that cannot be audited by its users is the wrong
trade.

This is engineering guidance, not legal advice. The owner should confirm the final choice, and the
distribution-side questions (see `spec/07_LEGAL_AND_RISKS.md`), with a qualified lawyer before a public
release.

## Constraints we cannot avoid

1. **The Linux kernel is GPLv2.** Any device build we distribute must come with the corresponding kernel
   source, including our changes, for that exact build. Keep per-device kernel trees public and tagged per
   release. This obligation applies whatever we choose for our own code.
2. **AOSP is mostly Apache 2.0**, with some components under other licenses. We must keep a bill of materials
   (component, version, license, source link, update owner) and not strip notices.
3. **Bundled apps keep their own licenses.** We cannot relicense Signal, F-Droid, or microG; check each one,
   including whether its license creates obligations we can meet as a distributor.
4. **Whatever we pick must stay compatible with copyleft components** so we can ship one image legally.

## Options

| Option | Project code | Copyleft? | Strongest argument for | Main risk |
|---|---|---|---|---|
| A | **Apache-2.0** (everything) | no | Maximum reuse and contribution; matches AOSP; corporate contributors can adopt it; patent grant included | Someone can ship a closed, tracking build of our installer or Lite app |
| B | **GPLv3** (or AGPL for network services) | strong | Any distributed derivative must stay open; hardest to fork into a proprietary product | Deters some app developers and mobile contributors; more friction for a solo maintainer |
| C | **MPL-2.0** per file | weak, file-level | Mixed tree works: our files protected, Apache-2.0 upstream untouched; simple compliance | Weaker against a closed fork than GPL; less familiar to Android contributors |
| D | **Mixed:** GPLv3 for OS code, Apache-2.0 for apps and docs | mixed | Reflects the real split: OS-level changes stay open, app-level code is easy to reuse | Two licenses means two sets of notices and contributor confusion; needs clear per-directory labeling |

## Recommendation at the time (superseded in one respect — see the note above)

**Option D**, with the split written into the tree before the first code lands:

- `privacy-manager/`, `patches/`, `manifest/`, `ota-server/`: **GPLv3**. These are the parts that make the
  OS what it is; a closed fork of them would defeat the project's purpose. Use **AGPLv3** for `ota-server/`
  and `installer-web/` specifically, because they are network services.
- `lite/`, `installer-desktop/`, `tools/`, `device-db/`, `docs/`: **Apache-2.0** — low-friction reuse, and
  consistent with AOSP conventions for anything that lives near AOSP code.
- Kernel trees: **GPLv2**, unmodified license text, published per device.

Why not GPLv3 everywhere: it makes the Lite app harder to reuse, and Lite is the recovery path for every
phone we cannot fully support. Why not Apache-2.0 everywhere: it lets a vendor take the OS core, add
tracking, and ship it on the reputation of the name.

## Decisions this needs from the owner

1. Choose option A, B, C, or D (or a variation).
2. **Contributor sign-off:** DCO (a `Signed-off-by` line per commit, lightweight) or a CLA (more admin, allows
   relicensing later). Recommendation: **DCO now**, revisit only if an audit or a paid contributor requires a CLA.
3. Trademark: decide whether the name and logo are protected separately from the code license. Copyright
   licenses grant no name rights; without a trademark policy anyone can ship a hostile build called "GoshBuzz".

## What happens after the decision

_Status: steps 1, 2 and 5 are done (`LICENSES/`, per-directory `LICENSE` markers, `DCO.md`); the bill of materials is not started._

1. Add the real `LICENSE` file(s) verbatim — copy the canonical text, do not retype it.
2. Add a per-directory license marker (short header or `README` note) matching the split.
3. Add license sections to `CONTRIBUTING.md`.
4. Record the choice, date, and reason in the decision log in `spec/02_PROJECT_SPEC.md`.
5. Create `docs/bill-of-materials.md` and start it with AOSP and app entries as they arrive.
