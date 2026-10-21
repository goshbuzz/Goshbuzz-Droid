# Threat model v1

Task T0.3. Status: **draft, awaiting owner review and sign-off.**
This document is designed to be uncomfortable to read. Its purpose is to stop the project from claiming
protection it does not deliver.

Scope of this document: what GoshBuzz OS defends against, what it only partly defends against, what it does
not defend against at all, and what remains true even when everything works as designed.

---

## 1. Assets we are protecting

| # | Asset | Why it matters |
|---|---|---|
| A1 | Message and call contents | Journalists, activists, abuse survivors; leaks can be physically dangerous |
| A2 | Contacts, photos, notes, documents | Irreversible harm if published or seized |
| A3 | Location history (past and live) | Reveals home, work, clinic, protest, source meetings |
| A4 | Identity of the user and their social graph | Association itself can be the risk, not just content |
| A5 | Account credentials | Compromise spreads to every other service |
| A6 | App usage patterns and habits | Feeds profiling, advertising, and coercion |
| A7 | Device integrity (that the OS is the OS we shipped) | A tampered system makes every other protection a lie |
| A8 | Availability of the device and its data | A bricked phone is a lost phone |

## 2. Adversaries

| ID | Adversary | Capability | Motivation |
|---|---|---|---|
| T1 | App and ad-tech SDKs | Runs inside the sandbox with granted permissions | Monetise behaviour |
| T2 | Google and vendor telemetry | Ships in stock system images, not in ours | Product improvement, profiling |
| T3 | Passive network observer | Sees traffic metadata on Wi-Fi or cellular; sees SNI/DNS without encryption | Profiling, censorship |
| T4 | Active network attacker | Can inject, downgrade, or block traffic; can run a malicious hotspot | Interception |
| T5 | Thief / opportunistic finder | Has the powered-on or powered-off device, unlimited time, commodity tools | Resale, data theft |
| T6 | Someone with brief physical access | A partner, colleague, border agent, or police officer holding an unlocked or locked phone | Inspection, coercion |
| T7 | Malicious app | Installed by the user, from a store or a sideloaded APK | Fraud, spying, ransomware |
| T8 | Carrier | Sees tower associations, call/SMS metadata, billing identity | Lawful requests, marketing, data sales |
| T9 | Forensic extraction tooling | Physical access plus commercial exploitation or chip-off | Evidence gathering |
| T10 | Nation-state with targeted exploits | Zero-days against the OS, kernel, or baseband | Surveillance |
| T11 | Supply-chain attacker | Compromises vendor blobs, build machine, mirrors, or signing | Mass compromise |

## 3. In scope: we intend to defend

| Threat | Primary mitigation | Phase |
|---|---|---|
| T1 tracking by apps/ads | Per-app firewall, permission monitor, no advertising ID, DNS filtering | 2, 3 |
| T2 Google/vendor telemetry | No Google code in base; connectivity check, captive portal, NTP, DNS moved off Google; network register | 2 |
| T3 passive observer | Encrypted DNS, always-on VPN/Tor option, MAC randomisation, traffic padding is **not** promised | 2, 3 |
| T4 active attacker | TLS by default, VPN kill switch, refusing downgrades where the platform allows | 2, 4 |
| T5 theft | File-based encryption, strong lockscreen, verified boot where keys allow, remote wipe (opt-in) | 2, 4 |
| T6 brief physical access | USB lockdown when locked, quick lock, hidden private space, duress features | 4 |
| T7 malicious app | App sandbox, SELinux enforcing, permission review, minimal preinstalled apps | 2, 4 |
| T11 tampered download | Signed images, published hashes, reproducible builds, offline keys | 4, 6 |

## 4. Partially in scope: we reduce but cannot remove

Say this plainly on the download page, in the installer, and in the Lite privacy score.

| Threat | What we can do | What remains |
|---|---|---|
| T3/T8 profiling | Encrypt DNS, randomise identifiers, block trackers | Traffic volume, timing, and destination IPs still visible to the network. A VPN shifts trust to the provider, it does not delete it |
| T8 carrier location | Reduce OS-initiated leaks; baseband isolation where hardware allows | **Cell tower location is unavoidable on a cellular network.** The carrier always knows roughly where the phone is. Airplane mode or leaving the phone behind are the only real answers |
| T5 forensics (T9) | Encryption, disabled USB data, verified boot, auto-reboot | A powered-on unlocked phone is defenceless against a determined examiner. Chip-off and cold-boot attacks are outside our control. "No extraction possible" is never a claim we make |
| T6 coercion | Duress PIN, decoy profile, quick wipe | Coercion defeats technical controls. A decoy can be suspected. Never tell a user duress features make them safe from a determined adversary |
| T7/T1 malicious or hostile apps | Sandbox, firewall, permission control | An app the user grants camera and contacts access to can use both. Some apps detect modified systems and refuse to run; others degrade silently |
| T4 active attacker | TLS validation, pinned DNS, kill switch | Captive portals and hostile networks can still block or fingerprint you |
| T10 targeted zero-days | Hardening, prompt patching | Hardening raises cost; it does not stop a funded adversary. We do not claim immunity |

## 5. Out of scope: we do not defend

- **Compromised baseband firmware.** Closed source, unaudited. We can restrict and isolate; we cannot inspect.
- **Hardware attacks** (chip-off, cold boot, bus probing, fault injection) on a device in an attacker's hands.
- **A compromised build machine or signing key** before we detect it. Mitigated by offline keys and reproducible
  builds, not eliminated.
- **Supply-chain compromise of vendor blobs.**
- **Nation-state targeting with zero-days.**
- **An adversary who already knows you.** Threat models do not hide a person from someone who has their phone number.
- **Physical safety.** This is software. If a user is in danger, the tool is not the plan.
- **Metadata the user's own contacts generate**, e.g. the other side of a conversation keeping logs.
- **Traffic analysis resistance.** We do not claim the OS makes traffic patterns unlinkable.

## 6. Assumptions we depend on

Break any of these and the model changes:

1. The bootloader is unlocked **by the owner**, using an official or publicly documented vendor method.
2. The user's copy was downloaded from the project's published location and its hash verified.
3. Verified boot is either enforced with our key, or the user has been shown an honest "unverified" notice.
4. The user chose a strong lockscreen. Encryption protects a powered-off phone, not a phone with PIN `1234`.
5. The base system contains no Google code, and microG toggles are visible and off unless enabled.
6. Updates actually arrive. An unpatched OS degrades to the security of its patch level; we display that level.

## 7. Residual risks, stated publicly

These appear in the README, the download page, and the first-run wizard. Non-negotiable wording:

- A phone on a cellular network can be located by the carrier. Always.
- The modem is closed source and cannot be audited by this project.
- A VPN moves trust to the VPN provider. Tor is slower and breaks some apps.
- Android 5–7 era devices are best-effort: old kernels, no vendor updates.
- Permanently locked bootloaders may never support a full install.
- Some banking, payment, and DRM apps will refuse to run or will break.
- No software can promise perfect privacy or security.

## 8. Per-release status table

Filled in for every release. Values: **mitigated** / **partly** / **not mitigated** / **n/a on this device**.

| Threat | Status | Evidence (test or doc) |
|---|---|---|
| T1 app/ad tracking | not mitigated yet | — |
| T2 Google telemetry | not mitigated yet | — |
| T3 passive observer | not mitigated yet | — |
| T4 active attacker | not mitigated yet | — |
| T5 theft, powered off | not mitigated yet | — |
| T6 brief physical access | not mitigated yet | — |
| T7 malicious app | not mitigated yet | — |
| T8 carrier location | partly (inherent limit) | This document, §4 |
| T9 forensic extraction | not mitigated yet | — |
| T10 targeted exploits | not mitigated (by design) | This document, §5 |
| T11 supply chain | not mitigated yet | — |

If this table is not filled in, the release is not ready.

## 9. Review

- Owner review and sign-off: **pending**
- Re-review triggers: a new tier ships, a new default app is added, any new network connection is added,
  any security feature is removed, and at minimum once per year.
