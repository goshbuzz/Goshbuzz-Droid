# LEGAL, SAFETY AND RISKS

This is guidance for planning, not legal advice. The owner should verify details for their country and for any country where the project is distributed, ideally with a qualified lawyer before launch.

## 1. Licensing
- **Linux kernel (GPLv2)**: publish the exact kernel source (including changes) for every device build you distribute. Keep per-device kernel repos public and tagged per release.
- **AOSP**: mostly Apache 2.0 with some GPL/other components. Maintain a bill of materials listing every component and its license.
- **Bundled apps**: record license, source link, version and update owner for each.
- **Project code**: choose a clear open-source license; require contributors to certify their contributions (DCO or CLA decision).

## 2. Trademarks and naming
- "Android" and the Android logo are Google trademarks. Do not use them in the product name or logo. Describe the project as "based on the Android Open Source Project".
- Check that "GoshBuzz OS" is acceptable alongside the existing GoshBuzz website brand and that no conflicting trademark exists.
- Do not use other projects' names or logos (LineageOS, GrapheneOS, microG, Signal, etc.) in a way that implies endorsement.

## 3. Proprietary software
- Never distribute Google apps or services.
- Vendor binary blobs: redistribution rights vary. Prefer scripts that extract blobs from the user's own device or from official vendor firmware packages. Document the approach per device.
- Respect the licenses of every third-party app and library.

## 4. Local laws
- Modifying your own phone is legal in many places but not everywhere; encryption, VPN and Tor rules differ by country; some countries restrict distribution of privacy or encryption software. The owner must check the rules for their own country and for target countries before public release.
- Be careful with features such as duress wipe and decoy profiles; document them as for lawful personal-safety use.

## 5. Safety risks to users
| Risk | Mitigation |
|---|---|
| Bricked phone | Device-specific checks, backups, recovery guides, test on spare devices first |
| Data loss when unlocking bootloader | Clear warnings, explicit confirmation, backup instructions |
| Lost warranty / vendor features | Disclose before install |
| Banking/payment/DRM apps failing | Disclose; offer sandboxed Play and microG; keep a compatibility list |
| False sense of security | Honest limits page; Privacy Score wording; no "untraceable" claims |
| Old phones unpatched | Mark as best-effort; show patch level; recommend newer devices for high-risk users |
| Malicious or tampered downloads | Signed images, published hashes, reproducible builds, HTTPS, mirrors with verification |
| Compromised signing keys | Offline key storage, rotation plan, revocation procedure |

## 6. Project risks
| Risk | Mitigation |
|---|---|
| Scope too large for a solo, self-funded developer | Phase gates; Lite tier first; limit supported devices; recruit maintainers |
| Learning curve of AOSP | Phase 1 learning path; build an existing ROM first |
| Locked bootloaders | Official/documented methods only; Lite tier covers these phones partially |
| Maintenance burden (patches, apps, devices) | Short default app list; device maintainers; automate builds; document everything |
| Funding for audits and servers | Donations, grants, sponsors; keep infrastructure static and cheap |
| Burnout | Realistic milestones; share work; celebrate small releases |
| Security vulnerabilities in own code | Private reporting policy, quick patches, audit, minimal custom code |

## 7. Responsible disclosure and updates
- Provide a private security contact and a response-time goal.
- Publish advisories with each security release.
- Keep an upstream-patch tracking process (AOSP monthly bulletins) and record the patch level in every release.

## 8. Agent behavior reminders
- If asked to do something illegal, unsafe for users, or against the hard rules in 01_SYSTEM_PROMPT, decline briefly and offer a safe alternative.
- If legal status is unclear, say so, explain what to check, and recommend professional advice.
