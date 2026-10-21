# ARCHITECTURE: GoshBuzz OS

## 1. Product tiers (how "works on every phone" is made realistic)
No single image runs on every phone. GoshBuzz uses tiers so every user gets something useful.

| Tier | Name | What it is | Works on | Install |
|---|---|---|---|---|
| 0 | **GoshBuzz Lite** | An app/launcher-style "privacy layer": hardened settings guide, local VPN-based firewall and DNS blocker, tracker blocking, permission monitor, private defaults checklist. No root, no flashing. | Almost any phone, including locked-bootloader and old ones (within Android API limits) | Install like a theme/app |
| 1 | **GoshBuzz GSI** | Generic System Image build | Android 8+ phones with Project Treble and unlockable bootloader | Web installer |
| 2 | **GoshBuzz Device builds** | Per-device images with deeper hardening and verified boot support | Selected popular phones | Web installer or desktop tool |
| 3 | **GoshBuzz Legacy** | Per-device builds for Android 5 to 7 phones | Selected old phones | Desktop tool / guided manual |
| 4 | **Pre-flashed phones** | Phones sold/shipped ready to use (optional, later) | Selected models | None needed |

Tier 0 matters: it gives locked and unsupported phones real privacy gains and acts as the "theme-like" on-ramp to the full OS.

## 2. Build system
- **Base**: AOSP (latest stable branch the project can maintain). Pin the exact branch/tag in the repo.
- **Learning path (Phase 1)**: first build a known ROM (for example LineageOS) for one owned phone to learn the toolchain: repo sync, lunch/build, flashing, logs. Then move to a clean AOSP-based tree.
- **Source layout**: a manifest repo (repo-tool manifests) that pins AOSP plus GoshBuzz patch sets. Patches kept small, documented, and rebased on each AOSP release.
- **Build host**: a Linux machine with large disk (several hundred GB free), 32 GB+ RAM recommended, fast SSD; or rented cloud builder. Document exact requirements after the first real build.
- **CI**: GitHub Actions or self-hosted runner for lint/docs/tests; full image builds on a build server.
- **Reproducible builds**: pinned toolchains, containerized build environment (Docker), deterministic timestamps, published hashes, and a verification guide.
- **Signing**: release keys generated offline, stored on encrypted offline media; test keys for development; document rotation. Never commit keys.

## 3. System components

### 3.1 Services layer (no Google)
- microG components (core services shim, location backends under user control, push via an open alternative) integrated as system apps or modules; user-visible toggles.
- Optional sandboxed Google Play: installed as normal, unprivileged apps by the user from their own sources; GoshBuzz provides only the installer helper and docs.
- Captive portal, connectivity check, NTP, and DNS defaults changed to non-Google, privacy-respecting endpoints (documented, replaceable).

### 3.2 Privacy framework (GoshBuzz Privacy Manager)
- **Location gate**: global switch and per-app rules; scanning for Wi-Fi/Bluetooth location off by default.
- **Network manager**: per-app firewall (using the platform's network stack and a local VPN service for old versions), DNS filter, encrypted DNS, optional VPN/Tor integration with kill switch.
- **Identifier manager**: per-network randomized MAC, no persistent ad ID, randomized hostname, minimal build fingerprint exposure where compatible.
- **Permission monitor**: logs access events locally (never uploaded), shows a timeline, supports revoke.
- **Presets**: Standard, Strong, Maximum map to bundles of the settings above.

### 3.3 Device security
- Encryption on by default; strong PIN/passphrase prompts; optional scrambled PIN pad.
- Auto-reboot and USB lockdown options when locked (hardening).
- Panic features: quick wipe gesture, duress PIN to a decoy profile, hide/lock private space.
- Remote services: opt-in lightweight service or SMS command for lock/locate/wipe, with end-to-end auth; documented threat model.
- Verified boot: on devices that allow custom keys, enroll the GoshBuzz signing key and show verified status; on others, show an honest "unverified" notice.
- Hardened allocator, SELinux strict, restricted debug interfaces by default.

### 3.4 Profiles
- Multi-user with private space for sensitive apps.
- Work/personal separation via managed profile model.
- Guest/burner: ephemeral storage, wiped on exit.

### 3.5 Default apps
Pick well-maintained open-source apps; each needs a license check, security review, update plan, and an owner. Keep the list short to protect the solo-maintainer workload.

### 3.6 Update system
- OTA client verifies signed update packages (A/B where supported).
- Update server serves static files; no accounts, no unique IDs; minimal logs with short retention; mirrors allowed.
- Metadata per device: build ID, hashes, changelog, security patch level.

## 4. Network and privacy architecture
- Default state: only user-initiated or documented connections (updates if enabled, DNS).
- Public document: "Every network connection GoshBuzz OS makes," maintained with each release.
- Optional features that contact servers (updates, remote wipe, crash reports) are individually switchable.

## 5. Installer architecture
See `04_INSTALLER_SPEC.md`. Components: device database, web installer (WebUSB), desktop tool, Lite app, hosted images, integrity checks.

## 6. Threat model (v1, to be maintained)
In scope: tracking by apps/ads/analytics, Google/vendor telemetry, passive network observers, device theft/loss, opportunistic physical access, malicious apps, tampered downloads.
Partially in scope: carrier tracking (towers), targeted network attacks, forensic extraction (mitigated, not eliminated).
Out of scope: nation-state targeted exploits, compromised hardware/baseband firmware, supply-chain attacks on vendor blobs.
Every release notes which of these are mitigated, partly mitigated, or not.

## 7. Repository structure (suggested)
```
goshbuzz/
  docs/                 user + developer docs, threat model, network-connections list
  manifest/             repo manifests pinning AOSP + patches
  patches/              ordered patch sets per component
  privacy-manager/      Privacy Manager app/service source
  lite/                 GoshBuzz Lite app
  installer-web/        WebUSB installer
  installer-desktop/    desktop flasher (if needed)
  device-db/            JSON/YAML device definitions (see 04)
  ota-server/           static update server config
  ci/                   build and verification scripts
  tools/                signing, hashing, release helpers
```

## 8. Compatibility notes by Android generation
- Android 5 to 7: no Treble; need per-device kernel/vendor trees; older crypto and security features; some modern privacy APIs missing, so Lite features may rely on VPN-service tricks. Mark as "best effort".
- Android 8+: Treble and GSI possible; most hardware features work through vendor interfaces.
- Latest versions: strongest platform security; verified boot and hardware-backed keystore support vary by device.
