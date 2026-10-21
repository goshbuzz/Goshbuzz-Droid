# INSTALLER SPEC: "Install it like a theme"

## 1. Goal
A non-technical person should be able to go from "I want this" to "it's running" with as few steps and as little fear as possible. The experience target is: **choose, tap, wait, done**.

## 2. Honest reality (agent must keep this in mind)
A full OS cannot be installed as simply as a wallpaper or theme. Most phones require an unlocked bootloader, which wipes data, and flashing a new system. So the simple, theme-like experience is delivered in layers:

1. **Instant layer (theme-like):** GoshBuzz Lite, one app install on almost any phone.
2. **Guided layer (a few clicks):** web installer over USB for supported phones.
3. **Fallback layers:** desktop tool, manual guide, pre-flashed phones.

The landing page presents these as one simple choice, and recommends the right one automatically.

## 3. The landing page (single front door)
Page flow:
1. Hero: "Take your phone back. Private by default." Primary button: **Check my phone**.
2. **Device detection**: the page detects the phone's model if connected, or asks the user to pick brand and model from a searchable list. (If the user is browsing from the phone itself, read model from the user agent as a hint only; confirm with the user.)
3. **Result card** with one recommended path and plain-language outcome:
   - "Full install supported" -> Web installer.
   - "Lite install available" -> GoshBuzz Lite.
   - "Not supported yet" -> notify me, how to help, alternative advice.
4. Secondary links: Desktop tool, manual guide, download images and checksums, buy pre-flashed phone, join community.

Design rules: one primary button per screen, plain language, big text, progress indicator, always show "what will happen" and "how to undo".

## 4. Path A: GoshBuzz Lite (theme-like)
- Install from the project site (APK with signature info) or an open-source app store.
- First run: setup wizard with Standard / Strong / Maximum presets.
- Applies what is possible without root: local-VPN firewall and DNS blocking, tracker lists, permission audit with one-tap links to the right system settings, guided steps to turn off Google data sharing, advertising ID reset instructions, location lockdown checklist.
- Shows a **Privacy Score** with honest wording (what is and is not protected).
- Offers a gentle "Upgrade to full GoshBuzz OS" if the phone is supported.
- Limit: cannot remove vendor or Google system apps, cannot add verified boot. Say so clearly.

## 5. Path B: Web installer (the "few clicks" path)
Based on WebUSB and fastboot/ADB-over-WebUSB in a supported desktop browser.

Steps (each is one screen):
1. **Welcome and check**: browser supported? USB cable? Computer OS drivers (Windows may need drivers; show guided help).
2. **Before you start** (checklist): backup warning, battery above a threshold, cable, time needed. Require the user to tick that they understand data will be erased.
3. **Prepare the phone**: show device-specific pictures/steps for Developer options, USB debugging, OEM unlocking. (Content comes from the device database.)
4. **Connect**: user plugs in; installer identifies model and verifies it matches the chosen image. Refuse if mismatch.
5. **Unlock bootloader** (only if needed): explain it will erase the phone; use only the official or well-documented method for that device; some vendors require a waiting period or an account. Show the wait/next-step guidance.
6. **Download and verify**: fetch image, verify checksum and signature in the browser before flashing.
7. **Flash**: progress bar, no technical output by default; "Show details" toggle for advanced users.
8. **First boot**: explain the first boot may take several minutes; show how to re-lock the bootloader if the device supports custom-key verified boot.
9. **Done**: link to first-run wizard and docs.
Always provide: **Cancel/Stop safely** guidance and **Recovery help** page (what to do if the phone does not boot; how to restore stock).

## 6. Path C: Desktop tool
For browsers/OS where WebUSB fails or for older devices needing special tools (for example older flash protocols). Same step flow as web installer; packaged for Windows, macOS, Linux; open-source, reproducibly built, signed.

## 7. Path D: Pre-flashed phones (optional later)
Partner or self-assembled refurbished phones shipped ready. Requires a business model and support plan; not in early phases.

## 8. Device database (drives everything)
Each device has a definition file, for example `device-db/<brand>/<codename>.yaml`:
```yaml
id: example-codename
brand: ExampleBrand
model: Example Phone 5
codename: example
android_versions_supported: [8, 9, 10]
treble: true
bootloader:
  unlockable: true
  method: official_vendor_tool   # official_vendor_tool | fastboot_command | not_unlockable
  wait_period_hours: 0
  erases_data: true
  relock_supported: false
tiers_available: [lite, gsi]
images:
  gsi:
    url: <release url>
    sha256: <hash>
    signature: <sig url>
user_steps:
  enable_developer_options: <doc link>
  enable_oem_unlock: <doc link>
known_issues: [camera_video_unstable, volte_not_working]
status: community-tested        # untested | community-tested | maintained
maintainer: <name or none>
last_tested: 2026-10
```
Rules: no device is marked "supported" without a successful test by a person; every known issue is shown to the user before install.

## 9. Safety and trust requirements
- Verify checksums and signatures of every image before flashing.
- Never flash an image that does not match the connected device codename.
- Warn clearly: data loss, possible warranty impact, possible loss of some banking/payment/DRM features.
- No telemetry in the installer by default. Any optional "send install result" is opt-in with preview.
- Installer code is open source; releases are signed and reproducible.
- Recovery documentation for every supported device.

## 10. Metrics for "simple"
- Time from landing page to a running system on a supported phone: target under 30 minutes (excluding vendor-imposed waiting periods).
- Number of screens in the happy path: target 10 or fewer.
- Lite install: under 3 minutes to a protected state.
- Usability test: at least 5 non-technical testers complete the Lite path unaided; at least 3 complete the web installer path with only on-screen help.
