# PROJECT SPEC: GoshBuzz OS

## 1. Vision
A free, open-source, privacy-first operating system based on the Android Open Source Project that installs easily on as many phones as possible, old and new, and keeps users private by default.

## 2. Audience
All three, served by one design:
- **Everyday people**: want easy privacy without hassle (presets, safe defaults).
- **Journalists and activists**: need strong protection (hardened mode, panic features, Tor/VPN).
- **Privacy enthusiasts**: want full control (advanced mode).

## 3. What "private" means (all four)
1. No Google tracking or data sharing.
2. Protection from apps and advertisers.
3. Protection from carriers and network snooping (as far as software can).
4. Protection if the phone is lost or stolen.

## 4. Project facts
| Item | Decision |
|---|---|
| Name | GoshBuzz OS (working name; no "Android" in branding) |
| Type | Free, open-source community project |
| Team | Solo developer at first |
| Funding | Self-funded for now (donations/grants/sponsors possible later) |
| Experience | Has installed custom ROMs as a user; never built a ROM or AOSP |
| Base | AOSP, from scratch (see risk note in 07) |
| Oldest target | Android 5 to 7 phones |
| Newest target | Latest Android phones |
| Brands | All brands, long term (Pixel, Samsung, Xiaomi, budget brands, etc.) |
| Bootloaders | Try to support locked ones where officially or publicly documented methods exist |
| Testing | Own phones and a few borrowed ones; later volunteer testers |
| Community | Website hub, GitHub, chat (prefer Matrix) |
| First milestone (owner's goal) | Full stable release for many devices. Agent must propose staged milestones (see 05) and be honest that this is not realistic as a first step |

## 5. Functional requirements

### 5.1 Google and services
- FR-G1: No Google code or proprietary Google apps in the base image.
- FR-G2: microG built in as a replacement for core Google services (push, location backend, etc.).
- FR-G3: Optional sandboxed Google Play add-on on newer phones, installed by the user from their own source, never redistributed by the project.
- FR-G4: A clear in-OS explanation of what each option does and costs in privacy.

### 5.2 Location
- FR-L1: Location is fully blocked by default.
- FR-L2: One global switch to enable it; then per-app control (never / while using / ask).
- FR-L3: No use of Wi-Fi/cell-based location lookups to third parties unless the user opts in.

### 5.3 Built-in privacy tools (all)
- FR-T1: Per-app firewall (block internet per app; separate Wi-Fi/mobile rules).
- FR-T2: DNS-level tracker and ad blocking (configurable lists; encrypted DNS).
- FR-T3: Randomized MAC address and other device identifiers; no stable advertising ID.
- FR-T4: Permission monitor: shows which apps accessed camera, mic, location, contacts, and when.

### 5.4 Device security
- FR-S1: Full-disk/file-based encryption on by default; strong lockscreen options.
- FR-S2: Remote lock/wipe/locate that does not depend on Google (own lightweight service and/or SMS-based command, opt-in).
- FR-S3: Panic/duress features: quick wipe, hidden profile, optional fake-PIN to open a decoy profile.
- FR-S4: Verified boot and tamper detection where the hardware allows (best on devices that accept a custom signing key).
- FR-S5: Hardened memory allocator, strict SELinux, app sandboxing as far as the base allows.

### 5.5 Network
- FR-N1: Baseband/modem isolation where the hardware supports it (document per device).
- FR-N2: Always-on VPN option and a Tor routing option for all traffic, with leak protection ("block connections without VPN").
- FR-N3: Randomized Wi-Fi MAC per network; disable Wi-Fi/Bluetooth scanning-for-location by default.
- FR-N4: Document every network connection the OS itself makes; default to none to third parties.

### 5.6 Profiles and isolation
- FR-P1: Multiple user profiles with a private space for sensitive apps.
- FR-P2: Separate work and personal profiles.
- FR-P3: Guest/burner mode that leaves no trace (no persistent storage, wiped on exit).

### 5.7 Default apps (each must be audited and kept updated)
- Private browser (no tracking, tracker blocking).
- Keyboard that sends no data anywhere.
- End-to-end encrypted messaging app (such as Signal-compatible).
- Camera and gallery with metadata stripping (location/EXIF removed on share).
- Offline maps and navigation with no tracking.
- App store for privacy-vetted apps (F-Droid-style), plus ability to install APKs directly.

### 5.8 Setup and settings
- FR-U1: First-run wizard with 3 presets: **Standard, Strong, Maximum**.
- FR-U2: Advanced mode exposing every option.
- FR-U3: Plain-language explanations; no jargon in the default view.

### 5.9 Updates
- FR-O1: Over-the-air updates built into the OS.
- FR-O2: Updates signed; clients verify signatures; rollback protection.
- FR-O3: Private update server: no user identifiers logged; documented data retention (none beyond what is needed).
- FR-O4: Monthly security patch cadence as a goal; backport critical fixes to old devices where feasible.

### 5.10 Telemetry and crash reports
- FR-X1: Off by default.
- FR-X2: Optional anonymous crash reports the user can turn on.
- FR-X3: Optional detailed reports the user explicitly chooses to send for bug fixing; always show a preview of the exact data, allow redaction.

### 5.11 Install
See `04_INSTALLER_SPEC.md`. Target: as simple as installing a theme.

## 6. Non-functional requirements
- Open source license for project code (choose and document; respect GPL obligations for the kernel).
- Reproducible builds so anyone can verify downloads match source.
- Independent security audit planned (after beta; needs funding).
- Performance: acceptable on low-end hardware. The owner accepts slower performance on old phones if needed for security.
- Privacy documentation and a public threat model.
- Accessibility basics in setup UI (font size, contrast, screen reader labels).

## 7. Out of scope (for now)
- Building a new kernel from scratch or a non-Android OS.
- Developing new exploits for locked bootloaders.
- Bundling Google proprietary software.
- Running a social network, cloud sync, or any user account system.
- Guarantees of anonymity on cellular networks.

## 8. Success metrics
- Phase 1: one phone boots a self-built image with documented privacy changes.
- Phase 2: public beta on 1 to 3 devices; at least 20 outside testers.
- Phase 3: GSI boots on at least 5 brands with a documented compatibility list.
- Ongoing: time to patch critical vulnerabilities; number of supported devices; audit results published.

## 9. Decision log (keep updated)
| Date | Decision | Reason |
|---|---|---|
| Oct 2026 | Google handling: none by default + microG + optional sandboxed Play | Privacy by default with app compatibility |
| Oct 2026 | Build plan: GSI first (Android 8+), per-device next, Android 5 to 7 last | Solo developer; Treble makes GSI broadest first step |
| Oct 2026 | Location blocked by default | Privacy goal |
| Oct 2026 | Telemetry optional with opt-in detailed reports | Need bug data without default collection |
| Oct 2026 | Name: GoshBuzz OS | Existing brand |
| Oct 2026 | Install experience: as simple as installing a theme | Owner requirement; see 04 for tiered plan |
| 2026-10-21 | **License:** GPL-3.0-or-later for all OS code; AGPL-3.0-or-later for `installer-web/` and `ota-server/`; Apache-2.0 for `docs/` and `device-db/`; kernel GPL-2.0-only per device | Owner asked for the maximum security and privacy posture. Copyleft lets users verify and republish what they run; AGPL covers the update server, the highest-value place to betray users. See `LICENSING.md` |
| 2026-10-21 | **Contributor sign-off:** DCO 1.1, no CLA | No relicensing without contributor consent; see `DCO.md` |
| 2026-10-21 | **Test device:** no purchase for now; Phase 1 targets the Android emulator first | Owner has no budget for hardware. Owner's available phone is a Tecno Spark, which is a Lite/tester device, not a build target (see `docs/testing/test-phone-shortlist.md`) |
