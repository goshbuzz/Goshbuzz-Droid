# TASK BACKLOG (first tasks)

Format: ID, task, acceptance criteria, notes. The agent should propose the next 3 tasks at session start and update statuses.

## Phase 0
**T0.1 License and governance**
- Acceptance: LICENSE file; CONTRIBUTING.md; CODE_OF_CONDUCT.md; SECURITY.md with a private reporting method.
- Notes: explain license choices and GPL kernel obligations in plain language; owner decides.

**T0.2 Repository and docs skeleton**
- Acceptance: public repo with the structure from 03_ARCHITECTURE section 7; README with vision and honest limits; docs index.

**T0.3 Threat model v1**
- Acceptance: `docs/threat-model.md` using section 6 of 03_ARCHITECTURE as the starting point; reviewed by the owner.

**T0.4 Network-connections document template**
- Acceptance: `docs/network-connections.md` with a table: component, destination, purpose, default on/off, how to disable.

**T0.5 Pick the test phone**
- Acceptance: a written comparison of 3 candidate test phones (easy bootloader unlock, active ROM community, Treble support, available second-hand), recommendation and cost estimate. The agent must verify device facts against current community and vendor documentation and flag anything unverified.

## Phase 1
**T1.1 Build host plan**
- Acceptance: list of hardware/cloud options with approximate cost; chosen setup; install steps for the required packages on a supported Linux distro.

**T1.2 First build of an existing ROM**
- Acceptance: owner flashes it on the test phone; written log of commands, errors and fixes; backup and recovery steps tested first.
- Notes: confirm before any flashing; remind the owner to back up and to expect data wipe.

**T1.3 First AOSP build and boot**
- Acceptance: image boots; build script committed; time and disk use recorded.

**T1.4 Containerized build environment**
- Acceptance: Dockerfile/script that builds the same image on a clean machine.

## Phase 2
**T2.1 Remove Google connectivity defaults**
- Acceptance: connectivity check, captive portal, NTP and DNS defaults replaced; documented; traffic capture shows none go to Google domains on fresh boot.

**T2.2 Integrate microG**
- Acceptance: microG works for push and location backends on the test phone; toggles visible; license compliance noted.

**T2.3 Location gate**
- Acceptance: location fully blocked by default; one global switch; per-app rules; tests for apps requesting location while blocked.

**T2.4 Identifier randomization**
- Acceptance: per-network MAC randomization verified with a second device or router logs; no stable ad ID.

**T2.5 Firewall and DNS blocking v1**
- Acceptance: per-app internet block works for Wi-Fi and mobile; DNS filter blocks a known tracker list; encrypted DNS option; documented limits.

**T2.6 24-hour traffic audit**
- Acceptance: method written; results table filled in `docs/network-connections.md`; every connection explained or removed.

## Phase 3
**T3.1 GoshBuzz Lite MVP**
- Acceptance: installable APK; wizard with 3 presets; local-VPN firewall + DNS block; permission audit; privacy score with honest wording; tested on 5 phones.

**T3.2 Landing page and device check**
- Acceptance: page with "Check my phone", result cards, links to Lite and docs; works on mobile; no third-party trackers or external fonts/scripts.

**T3.3 Device database v1 and schema validation**
- Acceptance: schema from 04 section 8; validation script in CI; at least 3 device entries with verified data.

**T3.4 Web installer prototype**
- Acceptance: flashes the test phone end to end in a supported browser; verifies checksum/signature before flashing; refuses mismatched devices; recovery guide linked.

## Phase 4 and later (outline)
- OTA client and update server.
- Default apps integration with license/security review per app.
- Permission monitor and presets.
- Remote lock/wipe and panic features.
- Profiles, private space, guest mode.
- Reproducible build verification guide.
- Beta release process and issue templates.

## Prompts the owner can reuse
- "Start session": "Read all context files. State the current phase, open decisions and propose the next 3 tasks."
- "Explain this": "Explain this step as if I have never built a ROM. What can go wrong and how do I recover?"
- "Review before I flash": "Review this plan for risks. List what could brick the phone and what I should back up."
- "Update docs": "Update the decision log, network-connections document and changelog for what we just did."
