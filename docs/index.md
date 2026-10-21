# Documentation index

## Start here

| Document | What it answers |
|---|---|
| [../README.md](../README.md) | What GoshBuzz OS is, and the honest limits |
| [spec/02_PROJECT_SPEC.md](spec/02_PROJECT_SPEC.md) | What we are building, requirement by requirement, plus the decision log |
| [spec/05_ROADMAP.md](spec/05_ROADMAP.md) | Phases, exit criteria, and what "done" means |
| [spec/06_TASK_BACKLOG.md](spec/06_TASK_BACKLOG.md) | The actual task list with acceptance criteria |
| [threat-model.md](threat-model.md) | Who we defend against, what we do not defend against |
| [network-connections.md](network-connections.md) | Every connection the OS makes (the register we are filling in during Phase 2) |

## Reference

| Document | What it answers |
|---|---|
| [spec/03_ARCHITECTURE.md](spec/03_ARCHITECTURE.md) | How it is built: tiers, build system, components |
| [spec/04_INSTALLER_SPEC.md](spec/04_INSTALLER_SPEC.md) | The install experience and the device database format |
| [spec/07_LEGAL_AND_RISKS.md](spec/07_LEGAL_AND_RISKS.md) | Licensing, trademarks, blobs, local-law risks |
| [licensing.md](licensing.md) | License options and a recommendation (decision pending) |
| [testing/phase-0-checklist.md](testing/phase-0-checklist.md) | Where Phase 0 actually stands |
| [testing/test-phone-shortlist.md](testing/test-phone-shortlist.md) | Which test phone to buy, and what must be verified first (T0.5) |

## For contributors

- [../CONTRIBUTING.md](../CONTRIBUTING.md): how to send a change, and the rules we do not bend
- [../SECURITY.md](../SECURITY.md): how to report a vulnerability privately
- [../CODE_OF_CONDUCT.md](../CODE_OF_CONDUCT.md): expected behaviour

## Status

Phase 0. Documentation skeleton exists; the OS does not. Anything in this repository that looks like a
download link is a placeholder until a signed release exists.

### About the spec pack

`docs/spec/` is an unmodified import of the owner's specification pack (v1.0, October 2026). Two notes:

- `01_SYSTEM_PROMPT.md` from that pack is **not** stored here. It contains the assistant's operating
  instructions and lives in the assistant configuration, not the repository. Add it here only if you decide
  you want it versioned.
- The pack's own advice applies: verify version numbers, URLs, and tool names against current official
  documentation before using them. Several facts in the specs are planning assumptions, not verified claims.
