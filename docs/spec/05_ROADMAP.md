# ROADMAP

The owner's goal is a full stable release for many devices. The agent must keep that goal in view but ship in stages, because a solo, self-funded developer new to ROM building cannot deliver broad device support in one step. Phase gates apply: **do not start the next phase until the exit criteria are met.**

## Phase 0: Foundations (weeks 1 to 2)
Tasks
- Choose a license for project code; record GPL obligations for kernels.
- Set up GitHub org/repo, README, code of conduct, contribution guide, security policy (private vulnerability reporting).
- Set up docs site skeleton and the project chat (Matrix preferred).
- Set up build machine plan (local or rented) and a dev test phone (spare, unlockable).
- Write v1 of the threat model and the "network connections" document.
Exit criteria: repo public, docs skeleton online, build machine ready, one dedicated test phone chosen.

## Phase 1: Learn and first boot (weeks 3 to 8)
Tasks
- Build an existing well-known ROM for the test phone from source; flash it; document every step and problem.
- Build AOSP for the same phone (or a Pixel/emulator target) and boot it.
- Containerize the build environment; script the build.
- Record exact hardware and time requirements.
Exit criteria: self-built image boots on the test phone; build is scripted; a "How I built it" guide exists.

## Phase 2: Privacy baseline on one device (weeks 9 to 16)
Tasks
- Remove Google connections from the base; replace connectivity/captive-portal/NTP/DNS defaults.
- Integrate microG.
- Location blocked by default with global switch.
- Encryption verified; SELinux enforcing; document defaults.
- Identifier randomization (MAC, ad ID).
- Per-app firewall and DNS blocking (first version).
- Network audit: capture traffic from a fresh boot for 24 hours; list every connection; fix or document each.
Exit criteria: fresh-boot traffic audit shows no undocumented third-party connections; privacy features work on the test phone; documented.

## Phase 3: Lite app and first installer (weeks 17 to 24)
Tasks
- Build GoshBuzz Lite (VPN-based firewall + DNS blocking, permission audit, checklist, presets, privacy score).
- Landing page with device check (even if only 1 to 3 devices listed).
- Web installer prototype for the test device.
- Device database v1.
Exit criteria: Lite works on at least 5 different phones; web installer flashes the test device end to end; 5 outside testers try it.

## Phase 4: Public beta on 1 to 3 devices (months 7 to 9)
Tasks
- Signed OTA updates and update server.
- Default apps integrated (browser, keyboard, messenger, camera, maps, app store).
- Privacy Manager: permission monitor, presets Standard/Strong/Maximum.
- Remote lock/wipe (opt-in), panic features, profiles, guest mode.
- Reproducible build verification guide.
- Public beta release, issue tracking, community onboarding.
Exit criteria: 20 outside testers; critical bugs triaged; reproducible build verified by at least one independent person.

## Phase 5: GSI and broader compatibility (months 10 to 14)
Tasks
- Build GoshBuzz GSI for Treble phones; test across brands.
- Compatibility matrix and known-issues list.
- Add more device definitions via community maintainers.
Exit criteria: GSI boots and is usable on at least 5 devices across at least 3 brands; maintainers recruited.

## Phase 6: Hardening, audit, legacy (months 15+)
Tasks
- Fundraise for an independent security audit; fix findings; publish report.
- Verified boot with custom key on supported devices.
- Legacy Android 5 to 7 per-device builds for a small set of popular old phones.
- Locked-bootloader support only via official or publicly documented methods, per device.
Exit criteria: audit report published; at least 2 legacy devices maintained; clear public statement of supported/unsupported devices.

## Phase 7: Stable release
Criteria: monthly update cadence running for 3 months, audit complete, documentation complete, installer success rate tracked, support/community process working.

## Standing tasks (every phase)
Update docs and decision log; keep the network-connections document current; track upstream security patches; triage issues; credit contributors.
